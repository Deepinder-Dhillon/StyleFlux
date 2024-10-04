//
//  BannerCardVM.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-01.
//

import Foundation

class BannerCardVM: FetchData<BannerCard> {
    
    override init() {
        super.init()
        Task {
            await fetchData(from: "BannerCard")
            await fetchImages()
        }
    }
    
    func fetchImages() async {
        for bannerCard in items {
            await loadImage(for: bannerCard, from: bannerCard.imageUrl)
        }
    }
}
