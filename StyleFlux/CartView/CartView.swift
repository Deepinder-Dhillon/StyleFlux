import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartProductDetailsManager: CartProductDetailsManager
    var cartVM = CartViewModel()

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.3, blue: 0.32), Color(red: 0.01, green: 0.01, blue: 0.013)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            
            if cartProductDetailsManager.getIDs().isEmpty{
                EmptyPreview()
                
            } else {
                VStack(alignment: .leading) {
                    Text("Bag")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white) // Set text color to white
                        .padding()
                    
                    List {
                        ForEach(Array(cartProductDetailsManager.productDetails.keys), id: \.self) { key in
                            if let productDetail = cartProductDetailsManager.productDetails[key],
                               let product = cartVM.items.first(where: { $0.id == productDetail.id }) {
                                
                                ProductRowView(
                                    product: product,
                                    productImage: cartVM.images[product.imageUrl],
                                    size: productDetail.size,
                                    quantity: productDetail.quantity
                                )
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                            }
                        }
                        .onDelete(perform: deleteItem)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Subtotal:")
                                    .foregroundColor(.white) // Set text color to white
                                Spacer()
                                Text(String(format: "$%.2f", calculateSubtotal()))
                                    .foregroundColor(.white) // Set text color to white
                            }
                            HStack {
                                Text("Tax:")
                                    .foregroundColor(.white) // Set text color to white
                                Spacer()
                                Text(String(format: "$%.2f", calculateTax()))
                                    .foregroundColor(.white) // Set text color to white
                            }
                            HStack {
                                Text("Total:")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white) // Set text color to white
                                Spacer()
                                Text(String(format: "$%.2f", calculateTotal()))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white) // Set text color to white
                            }
                        }
                        .padding(.trailing)
                        .padding(.vertical)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        
                        
                        
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
                    .listRowSeparator(.hidden)
                    .padding(.leading)
                    
                    
                    
                    
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Text("Place Order")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.lightGreen)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                } .background(Color.clear)
            }
        }
       
        .onAppear {
            let productIDs = cartProductDetailsManager.getIDs()
            Task {
                await cartVM.fetchCartProducts(productIDs: productIDs)
                await cartVM.fetchImages(for: cartVM.items)
            }
        }
        .onChange(of: cartProductDetailsManager.productDetails.keys) { _, _ in
            let productIDs = cartProductDetailsManager.getIDs()
            Task {
                await cartVM.fetchCartProducts(productIDs: productIDs)
                await cartVM.fetchImages(for: cartVM.items)
            }
        }
    }

    // Calculation and Helper Methods
    private func calculateSubtotal() -> Double {
        let subtotal = cartProductDetailsManager.productDetails.values.reduce(0.0) { total, productDetail in
            let quantity = productDetail.quantity
            let productPrice = cartVM.items.first { $0.id == productDetail.id }?.price ?? "0"
            let productTotal = (Double(productPrice) ?? 0.0) * Double(quantity)
            return total + productTotal
        }
        return subtotal
    }

    private func deleteItem(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let keyToRemove = Array(cartProductDetailsManager.productDetails.keys)[index]
        
        cartProductDetailsManager.productDetails.removeValue(forKey: keyToRemove)

        Task {
            await cartProductDetailsManager.saveProductDetails()
            await cartVM.fetchImages(for: cartVM.items)
        }
    }
    
    private func calculateTax() -> Double {
        return calculateSubtotal() * 0.12
    }
    
    private func calculateTotal() -> Double {
        return calculateSubtotal() + calculateTax()
    }
}

struct ProductRowView: View {
    var product: Product
    var productImage: UIImage?
    var size: String
    var quantity: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 16) {
                ThumbView(image: productImage, height: 150)
               

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                    Text(product.tag)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.white)

                    Text("Size: \(size)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white) // Set text color to white

                    Spacer()

                    HStack {
                        Text("Qty: \(quantity)")
                            .foregroundColor(.white) // Set text color to white
                        Spacer()
                        Text("$\(product.price)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
             
                    
                }
                .padding(.trailing)
                
            }
            
            Divider()
                .background(Color.white)
            .padding(.vertical, 15)
            
 
            
            
        }
        

    }
}

struct EmptyPreview: View {
    var body: some View {
        VStack {
            Text("Your cart is empty.")
                .font(.title2)
                .padding()
                .foregroundColor(.white)
            Image(systemName: "cart")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let productIDsManager = CartProductDetailsManager(userID: "MomBq9LvuGSbqE6EvLvrpMUPFrw1")
        productIDsManager.productDetails = [
            "x015": CartProductDetails(id: "x015", size: "M", quantity: 2),
            "x016": CartProductDetails(id:"x016", size: "L", quantity: 1)
        ]

        return CartView()
            .environmentObject(productIDsManager)
    }
}
