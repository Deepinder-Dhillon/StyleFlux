//
//  Product.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

import Foundation

// Product Model
struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let price: String
    let label: String
    let sizes: [String]
    let tag: String
    let heading: String
    let bodyText: String
    let imageUrl: String

    static let sample = Product(
        id: "x001",
        name: "Gazelle Indoor Shoes",
        price: "160",
        label: "Shoes",
        sizes: ["6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10"],
        tag: "Basketball Shoes",
        heading: "ICONIC GAZELLE SHOES MADE WITH SUPPLE SUEDE",
        bodyText: "These adidas Gazelle Indoor shoes give you comfort and retro style, with a premium suede upper and two-color 3-Stripes. Originally designed as an indoor soccer training shoe, these kicks pay homage to how far the Gazelle has come since its debut.",
        imageUrl:"https://firebasestorage.googleapis.com:443/v0/b/styleflux-66a8e.appspot.com/o/Products%2FGazelle%20Indoor%20Shoes.png?alt=media&token=b545738e-5f71-411d-9089-77fa7e508a0b"
    )
}
