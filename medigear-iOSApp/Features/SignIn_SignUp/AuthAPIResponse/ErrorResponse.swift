//
//  ErrorAPIResponse.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 23/3/23.
//

import Foundation


struct ErrorResponse: Codable {
    let data: String?
    let error: ErrorDetails
}

struct ErrorDetails: Codable {
    let status: Int
    let name: String
    let message: String
}

