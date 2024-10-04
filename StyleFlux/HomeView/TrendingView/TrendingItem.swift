//
//  TrendingItem.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

import Foundation

struct TrendingItem: Codable, Identifiable {

  let id: String
  let name: String
  let price: String
  let imageUrl: String
  let label: String

}
