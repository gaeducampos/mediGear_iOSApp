//
//  OrderService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import Foundation
import Combine


final class OrderService {
    let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    
    func getUserOrdersCompleted(with userId: Int) -> AnyPublisher<[Order], Error> {
        var request = URLRequest.fastApiBaseRequest
            .add(path: "/get/orders/completed")
            .addParameters(value: "\(userId)", name: "user_id")
        
        request.httpMethod = "GET"
        
        return networkProvider.request(for: request)
    }
    
    func getUserOrdersActive(with userId: Int) -> AnyPublisher<[Order], Error> {
        var request = URLRequest.fastApiBaseRequest
            .add(path: "/get/orders/active")
            .addParameters(value: "\(userId)", name: "user_id")
        
        request.httpMethod = "GET"
        
        return networkProvider.request(for: request)
    }
    
    func getUserOrdersPending(with userId: Int) -> AnyPublisher<[Order], Error> {
        var request = URLRequest.fastApiBaseRequest
            .add(path: "/get/orders/pending")
            .addParameters(value: "\(userId)", name: "user_id")
        
        request.httpMethod = "GET"
        
        return networkProvider.request(for: request)
    }
    
    
    func getUserOrdersPDF(with userId: Int) -> AnyPublisher<OrderPDF, Error> {
        var request = URLRequest.fastApiBaseRequest
            .add(path: "/get/pdf")
            .addParameters(value: "\(userId)", name: "user_id")
        
        request.httpMethod = "GET"
        return networkProvider.request(for: request)
    }
    
}
