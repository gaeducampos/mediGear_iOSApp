//
//  ProductFilteringService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 10/4/23.
//

import Foundation
import Combine

struct ProductService {
    private let networkProvider: NetworkProvider
    
    init(netWorkProvider: NetworkProvider) {
        self.networkProvider = netWorkProvider
    }

    func getFilteredProductsByName(for productName: String) -> AnyPublisher<APIResponse<[Product]>, Error> {
        
        var request = URLRequest.baseRequest
            .add(path: "/products")
            .addParameters(value: productName, name: "filters[name][$contains]")
    
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return networkProvider.request(for: request)
        
    }
}
