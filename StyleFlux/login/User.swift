//
//  User.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-06.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var cartDetails: [String: CartProductDetails]

    
    var intials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}


