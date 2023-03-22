//
//  User.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import Foundation


struct User: Decodable {
    let id: Int
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
    let createdAt: String
    let updatedAt: String
    let fullName: String
}
