//
//  Product.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 10/4/23.
//

import Foundation


struct Product: Codable, Identifiable {
    let id: Int
    var attributes: ProductAttributes
}



struct ProductAttributes: Codable {
    let name: String
    let description: String
    let serial_number: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let dimensions: ProductDimensions
    let price: String
    let currency: String
    let date_added: String
    let amount: Int
    let isAvailable: Bool
    let img: String
    var sub_category: APIResponse<MedicalMinistration>?
    
    
}

struct ProductDimensions: Codable {
    let width: String
    let height: String
    let depth: String
    let weight: String
    
    
}
