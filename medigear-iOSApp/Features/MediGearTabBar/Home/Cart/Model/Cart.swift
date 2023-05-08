//
//  Cart.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/4/23.
//

import Foundation

struct Cart: Encodable, Decodable {
    let total: Double
    var isActive = false
    var isComplete = false
    var isPending = true
    let location: String
    let userId: Int
    let deliveryTime: String
    let order_details: [String]
    var orderReference = ShortCodeGenerator.shortUUID(for: UUID())
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

