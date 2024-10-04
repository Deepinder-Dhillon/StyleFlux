import SwiftUI


struct ImageView: View {
    let imageUrl: String
    let shopVM: ShopVM
    
    var body: some View {
        if let image = shopVM.images[imageUrl] {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
        } else {
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 400)
                .onAppear {
                    Task {
                        await shopVM.loadImage(for: Product.sample, from: imageUrl)
                    }
                }
        }
    }
}

struct ProductPage: View {
    let product: Product
    var shopVM: ShopVM
    @EnvironmentObject var productIDsManager: CartProductDetailsManager
    
    @State private var selectedSize: String = "Select Size"
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.3, blue: 0.32), Color(red: 0.01, green: 0.01, blue: 0.013)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 2) {
                    ImageView(imageUrl: product.imageUrl, shopVM: shopVM)
                    
                    ProductDetailsView(product: product)
                    Divider()
                        .background(Color.white)
                    
                    SizeMenu(sizes: product.sizes, selectedSize: $selectedSize)
                    
                    AddToCartButton(selectedSize: $selectedSize, product: product)
                    
                    Spacer()
                    
                    ProductDescriptionView(product: product)
                }
            }
        }
    }
}

struct ProductDetailsView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
            
            Text(product.tag)
                .opacity(0.8)
            
            Text("$" + product.price)
                .font(.headline)
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct SizeMenu: View {
    @State var sizes = ["6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10"]
    @Binding var selectedSize: String

    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(selectedSize == "Select Size" ? selectedSize : "Size: \(selectedSize)")
                .padding(.top)
                .font(.title3)
                .fontWeight(.semibold)
               
                    .foregroundColor(.white)
                    .cornerRadius(8)
        
            
        
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(sizes, id: \.self) { size in
                            Button {
                                selectedSize = size
        
                            } label: {
                                Text(size)
                                    .frame(minWidth: 40)
                                    .padding()
                                    .background(selectedSize == size ? Color.white : Color.white.opacity(0.3))
                                    .foregroundColor(selectedSize == size ? Color.black : Color.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.top, 5)
                  
                }
        
        }
        .padding(.horizontal)
    }
}

struct AddToCartButton: View {
    @Binding var selectedSize: String
    @EnvironmentObject var productIDsManager: CartProductDetailsManager
    var product: Product
    
    var body: some View {
        Button {
            if selectedSize == "Select Size" {
              
            } else {
                productIDsManager.addProduct(id: product.id, size: selectedSize, quantity: 1)
            }
        } label: {
            Text("Add To Cart")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lightGreen)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
}

struct ProductDescriptionView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.heading)
                .font(.headline)
                .padding(.bottom)
            Text(product.bodyText)
        }
        .foregroundColor(.white)
        .padding()
    }
}



 


#Preview {

    ProductPage( product: Product.sample, shopVM: ShopVM())

     
}

