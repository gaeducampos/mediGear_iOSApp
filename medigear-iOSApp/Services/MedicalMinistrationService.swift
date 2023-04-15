//
//  MedicalSpecialtiesService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation
import Combine


final class MedicalMinistrationService {
    private let netWorkProvider: NetworkProvider
    
    init(netWorkProvider: NetworkProvider) {
        self.netWorkProvider = netWorkProvider
    }
    
    func getMedicalSpecialties() -> AnyPublisher<APIResponse<[MedicalMinistration]>, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/medical-specialties")
            .addParameters(value: "*", name: "populate")
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return netWorkProvider.request(for: request)
    }
    
    func getMedicalManufacturers() -> AnyPublisher<APIResponse<[MedicalMinistration]>, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/manufacturers")
            .addParameters(value: "products", name: "populate")
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkProvider.BearerToken)", forHTTPHeaderField: "Authorization")
        
        return netWorkProvider.request(for: request)
    }
    
    func getFilteredProductsBySubCategory(for subCategory: String) -> AnyPublisher<APIResponse<[Product]>, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/products")
            .addParameters(value: "sub_category", name: "populate")
            .addParameters(value: subCategory, name: "filters[sub_category][name][$eq]")
        
        print(request.url?.description)
        
        request.httpMethod = "Get"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return netWorkProvider.request(for: request)
        
    }
    
    
    
}
