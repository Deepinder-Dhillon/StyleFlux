import Foundation
import FirebaseFirestore
import FirebaseStorage



func loadProducts() -> [Product]? {
    guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
        print("Failed to locate test.json in the bundle.")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}

func uploadProductImages() {
    guard let products = loadProducts() else {
        print("No products found to upload.")
        return
    }

    // Initialize Firestore and Storage references
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()

    for product in products {
        // Load the image file from the "Images" folder inside the app bundle
        guard let localFile = Bundle.main.url(forResource: product.imageUrl, withExtension: nil, subdirectory: "Images") else {
            print("Failed to find image \(product.imageUrl) in the Images folder.")
            continue
        }
        
        // Create a reference for the file in Firebase Storage
        let path = "Products/\(product.name).png"
        let fileRef = storageRef.child(path)
        
        // Upload the file to Firebase Storage
        _ = fileRef.putFile(from: localFile, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error)")
                return
            }
            
            // Get the download URL of the uploaded image
            fileRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve download URL: \(error)")
                    return
                }
                
                if let downloadURL = url {
                    // Prepare data to save in Firestore, including the image URL
                    let productData: [String: Any] = [
                        "id": product.id,
                        "name": product.name,
                        "price": product.price,
                        "label": product.label,
                        "sizes": product.sizes,
                        "tag": product.tag,
                        "heading": product.heading,
                        "bodyText": product.bodyText,
                        "imageUrl": downloadURL.absoluteString
                    ]
                    
                    db.collection("Products").document(product.id).setData(productData) { error in
                        if let error = error {
                            print("Failed to save product to Firestore: \(error)")
                        } else {
                            print("Product successfully uploaded and saved to Firestore.")
                        }
                    }
                }
            }
        }
        

    }
}


