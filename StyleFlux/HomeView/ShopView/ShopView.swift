import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct ShopView: View, Equatable {
    
    static func == (lhs: ShopView, rhs: ShopView) -> Bool {
        true
    }
    
    @State private var selectedProduct: Product?
    @State private var showProductPage = false
    @EnvironmentObject var productIDsManager: CartProductDetailsManager
    var shopVM = ShopVM()
    var categoriesLabel = Label(labels: ["All", "Shoes", "Winter", "Pants",
                                                   "Hoodies", "Jackets", "Sports", "Shirts",
                                                   "Accessories", "Summer"])
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.3, blue: 0.32), Color(red: 0.01, green: 0.01, blue: 0.013)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
      
                VStack(alignment: .leading) {
                    Text("ShopFlux")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                    
                    LabelButtonsView(labels: categoriesLabel)
                    VStack(alignment: .leading){
                        FilteredProductCards(
                            selectedCategory: categoriesLabel.selectedLabel,
                            shopVM: shopVM,
                            onSelect: { product in
                                selectedProduct = product
                                showProductPage = true
                            }
                        )
                    }
                    .sheet(item: $selectedProduct) { product in
                        ProductPage(product: product, shopVM: shopVM)
                    }
                }

        }
        .onAppear {
            Task {
                await shopVM.fetchData(from: "Products")
                await shopVM.fetchImages()
            }
        }
    }
}


struct ProuductCard: View {
    
    let item: Product
    let shopVM: ShopVM

    var body: some View {
        VStack(alignment: .leading){

            ThumbView(image: shopVM.images[item.imageUrl], height: 200)

            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    

                Text(item.tag)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))

                Text("$"+item.price)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .padding(.leading)
        }
        .frame( maxHeight: 280)
    }
}

struct FilteredProductCards: View {
    
    let selectedCategory: String
    let shopVM: ShopVM
    let onSelect: (Product) -> Void
    let columns = [GridItem(.flexible(),spacing: 15), GridItem(.flexible(),spacing: 15)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach( shopVM.items.filter { $0.label == selectedCategory || selectedCategory == "All" })
                {item in ProuductCard(item: item, shopVM: shopVM)
                        .onTapGesture {onSelect(item)}
                }
            }
        }
    }
}

#Preview {

    ShopView()
        
}
