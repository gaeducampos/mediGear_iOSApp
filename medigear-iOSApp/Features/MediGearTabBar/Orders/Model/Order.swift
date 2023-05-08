//
//  Order.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 19/4/23.
//

import Foundation

struct Order: Codable {
    let id: Int
    let attributes: OrderAttributes
}

struct OrderAttributes: Codable {
    let total: Float
    let isActive: Bool
    let isComplete: Bool
    let isPending: Bool
    let location: String
    let userId: Int
    let deliveryTime: String
    let orderReference: String
    let createdAt: String
    let updatedAt: String
}

struct OrderDetails: Decodable, Encodable {
    let id: Int
    let attributes: OrderDetailsAttributes
}

struct OrderDetailsAttributes: Decodable, Encodable {
    let quantity: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    
}
