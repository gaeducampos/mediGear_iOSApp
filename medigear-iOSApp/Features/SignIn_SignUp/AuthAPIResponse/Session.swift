//
//  Session.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import Foundation


struct Session: Codable {
    let jwt: String
    let user: User
}
