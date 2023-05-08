//
//  ShortCodeGenerator.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 17/4/23.
//

import Foundation
struct ShortCodeGenerator {
    static func shortUUID(for uuid: UUID) -> String {
        let data = withUnsafeBytes(of: uuid.uuid) { Data($0) }
        let base64Encoded = data.base64EncodedData(options: [])
        let base64String = base64Encoded.map { String(format: "%02hhx", $0) }.joined()
        let shortId = String(base64String.prefix(6))
        return shortId
    }


    
}
