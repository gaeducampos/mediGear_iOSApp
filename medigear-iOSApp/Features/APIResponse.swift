//
//  APIResponse.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation

struct APIResponse<Value: Decodable>: Decodable {
    struct Meta: Decodable {
        let pagination: Pagination
    }
    struct Pagination: Decodable {
        let page: Int
        let pageSize: Int
        let pageCount: Int
        let total: Int
    }
    
    let data: Value
    let meta: Meta?
}
