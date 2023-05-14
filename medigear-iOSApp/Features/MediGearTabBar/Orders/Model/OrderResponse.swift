//
//  Order.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 19/4/23.
//

import Foundation

struct OrderResponse: Codable {
    let id: Int
    let attributes: OrderResponseAttributes
}

struct OrderResponseAttributes: Codable {
    let total: Float
    let status: Status
    let location: String
    let userId: Int
    let deliveryTime: String
    let orderReference: String
    let createdAt: String
    let updatedAt: String
}

struct OrderResponseDetails: Decodable, Encodable {
    let id: Int
    let attributes: OrderResponseDetailsAttributes
}

struct OrderResponseDetailsAttributes: Decodable, Encodable {
    let quantity: Int
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    
}
