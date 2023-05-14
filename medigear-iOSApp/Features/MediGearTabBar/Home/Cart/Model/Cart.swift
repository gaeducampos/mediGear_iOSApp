//
//  Cart.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/4/23.
//

import Foundation

enum Status: String, Codable {
    case pending = "s1"
    case active = "s2"
    case complete = "s3"
}

struct Cart: Encodable, Decodable {
    let total: Double
    let location: String
    let userId: Int
    let deliveryTime: String
    let order_details: [String]
    var orderReference = ShortCodeGenerator.shortUUID(for: UUID())
    let status: Status
}

struct CartProductOrderDetails: Encodable, Decodable {
    var product: String
    let quantity: Int
}


struct CartProduct: Identifiable, Encodable, Decodable {
    var id = UUID()
    var product: Product
    let quantity: Int

}


