//
//  TrendingVM.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

final class TrendingVM: FetchData<TrendingItem> {

  override init() {
    super.init()
    Task {
      await fetchData(from: "Trending")
      await fetchImages()
    }
  }

  func fetchImages() async {
    for trendingCard in items {
        await loadImage(for: trendingCard, from: trendingCard.imageUrl)
    }
  }
}
