//
//  File.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 29/3/23.
//

import Foundation

struct MedicalMinistration: Decodable, Identifiable {
    let id: Int
    let attributes: MedicalMinistrationAttributes
}


struct MedicalMinistrationAttributes: Decodable {
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let img: String
    let name: String
    let products: APIResponse<[Product]>?
    let sub_categories: APIResponse<[MedicalSubCategory]>?
    
    var subCategories: [MedicalSubCategory] {
        sub_categories?.data ?? []
    }
}
