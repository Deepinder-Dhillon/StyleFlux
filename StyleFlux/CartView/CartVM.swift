//
//  CartVM.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

import Foundation
import Firebase




@MainActor
class CartProductDetailsManager: ObservableObject {
    @Published var productDetails: [String: CartProductDetails] = [:]
    private var userID: String
    
    init(userID: String) {
        self.userID = userID
        Task {
            await loadProductDetails()
        }
    }

    func addProduct(id: String, size: String, quantity: Int) {
        let key = "\(id)-\(size)"
        
        if productDetails[key] != nil {
            productDetails[key]!.quantity += quantity
        } else {
            productDetails[key] = CartProductDetails(id: id, size: size, quantity: quantity)
        }
        
        Task {
            await saveProductDetails()
        }
    }
    
    func deleteProductDetails() async {
        do {
            try await Firestore.firestore().collection("users").document(userID).updateData(["cartDetails": FieldValue.delete()])
        } catch {
            print("Error deleting cart details: \(error.localizedDescription)")
        }
    }
    
    func getIDs() -> [String] {
        return productDetails.values.map { $0.id }
    }
    
    func saveProductDetails() async {
        let encodedDetails = try? Firestore.Encoder().encode(productDetails)
        do {
            try await Firestore.firestore().collection("users").document(userID).updateData(["cartDetails": encodedDetails ?? [:]])
            
        } catch {
            print("Failed to update product details: \(error.localizedDescription)")
        }
    }
    
    private func loadProductDetails() async {
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
            if let userCartDetails = snapshot.data()?["cartDetails"] as? [String: [String: Any]] {
                let decodedDetails = userCartDetails.compactMapValues { try? Firestore.Decoder().decode(CartProductDetails.self, from: $0) }
                self.productDetails = decodedDetails
            }
        } catch {
            print("Error loading product details: \(error.localizedDescription)")
        }
    }
}


@Observable class CartViewModel: FetchData<Product> {
     var cartData: [String] = []


    override init() {
        super.init()
    }

    func fetchCartProducts(productIDs: [String]) async {
        if productIDs.isEmpty {
            return
        }
        let db = Firestore.firestore()

        do {
            let snapshot = try await db.collection("Products")
                .whereField(FieldPath.documentID(), in: productIDs)
                .getDocuments()

            let fetchedProducts = snapshot.documents.compactMap { document -> Product? in
                try? document.data(as: Product.self)
            }

            DispatchQueue.main.async {
                self.items = fetchedProducts
            }
        } catch {
            print("Error fetching specific products: \(error.localizedDescription)")
        }
    }

    func fetchImages(for products: [Product]) async {
        for product in products {
            await loadImage(for: product, from: product.imageUrl)
        }
    }

}
