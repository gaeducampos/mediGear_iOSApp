//
//  MedicalSpecialtiesService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation
import Combine


class MedicalMinistrationService {
    private let netWorkProvider: NetworkProvider
    
    init(netWorkProvider: NetworkProvider) {
        self.netWorkProvider = netWorkProvider
    }
    
    func getMedicalSpecialties() -> AnyPublisher<APIResponse<[MedicalMinistration]>, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/medical-specialties")
            .addParameters(value: "sub_categories", name: "populate")
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return netWorkProvider.request(for: request)
    }
    
    func getMedicalManufacturers() -> AnyPublisher<APIResponse<[MedicalMinistration]>, Error> {
        var request = URLRequest.baseRequest
        request.url?.append(path: "/manufacturers")
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkProvider.BearerToken)", forHTTPHeaderField: "Authorization")
        
        return netWorkProvider.request(for: request)
    }
    
    
    
}
