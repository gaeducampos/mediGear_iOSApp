//
//  Order.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import Foundation

struct Order: Decodable, Identifiable {
    let id: UUID
    let orderReference: String
    let status: Status
    let total: Double
    let deliveryTime: String
    let orderDetails: [OrderDetails]
    
    
}

struct OrderDetails: Decodable, Identifiable {
    let id = UUID()
    let product: ProductsAttributes
    let quantity: Int
}

struct ProductsAttributes: Decodable{
    let data: Product
}

struct OrderPDF: Decodable {
    let pdf: String
}
