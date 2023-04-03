//
//  MedicalSubcategory.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 31/3/23.
//

import Foundation


struct MedicalSubCategory: Decodable, Identifiable {
    let id: Int
    let attributes: MedicalSubCategoryAttributes
}


struct MedicalSubCategoryAttributes: Decodable {
    let name: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let img: String
    let category: String
}
