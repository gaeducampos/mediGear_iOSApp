//
//  APIResponse.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation

struct APIResponse<Value: Codable>: Decodable, Encodable {
    struct Meta: Decodable, Encodable {
        let pagination: Pagination
    }
    struct Pagination: Decodable, Encodable {
        let page: Int
        let pageSize: Int
        let pageCount: Int
        let total: Int
    }
    
    let data: Value
    let meta: Meta?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encodeIfPresent(meta, forKey: .meta)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }
}

struct ForgotPasswordResponse: Decodable {
    let ok: Bool
}

struct EmailToResetPassword: Encodable {
    let email: String
}
