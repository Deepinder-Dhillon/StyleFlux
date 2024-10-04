//
//  FetchData.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-08-28.
//

import Foundation
import FirebaseFirestore
import Observation
import FirebaseStorage


@Observable class FetchData<T: Codable & Identifiable> {
    var items: [T] = []
    var images: [String: UIImage] = [:]

    private let tempDirectory = NSTemporaryDirectory()

    func fetchData(from collection: String) async {
        let db = Firestore.firestore()

        do {
            let snapshot = try await db.collection(collection).getDocuments()
            let data = snapshot.documents.compactMap { document -> T? in
                try? document.data(as: T.self)
            }
            self.items = data
        } catch {
            print("Error fetching data from \(collection): \(error.localizedDescription)")
        }
    }

    func loadImage(for item: T, from urlString: String) async {
        let filename = "\(item.id)"
        let filePath = tempDirectory.appending(filename)
        
        if let cachedImage = UIImage(contentsOfFile: filePath) {
            DispatchQueue.main.async {
                self.images[urlString] = cachedImage
            }
            return
        }

        do {
            let storageRef = Storage.storage().reference(forURL: urlString)
            let data = try await storageRef.data(maxSize: 1 * 1024 * 1024)
            if let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.images[urlString] = downloadedImage
          
                }
            }
        } catch {
            print("Error loading image from Firebase Storage: \(error.localizedDescription)")
        }
    }

    
}

