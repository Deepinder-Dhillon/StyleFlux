//
//  ShopVM.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

import Foundation

final class ShopVM: FetchData<Product> {
    func fetchImages() async {
        for productCard in items {
            await loadImage(for: productCard, from: productCard.imageUrl)
        }
    }
}
