//
//  APIPostData.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 24/4/23.
//

import Foundation

struct APIPostData<Value: Codable>: Encodable, Decodable {
    let data: Value
    let meta: Meta
    
    struct Meta: Decodable, Encodable {}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(meta, forKey: .meta)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }
}
