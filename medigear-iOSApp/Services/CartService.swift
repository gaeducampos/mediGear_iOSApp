//
//  CartService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 17/4/23.
//

import Foundation
import Combine

final class CartService {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func createOrderDetails(for singleProductOrder: APIPostData<CartProductOrderDetails>) -> AnyPublisher<APIPostData<OrderDetails>, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/order-details")
        
        request.httpMethod = "POST"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        let jsonEnconder = try? JSONEncoder().encode(singleProductOrder)
        request.httpBody = jsonEnconder
        
        return networkProvider.request(for: request)
    }
    
    func createOrder(for cart: APIPostData<Cart>) -> AnyPublisher<APIPostData<Order>, Error> {
        
        var request = URLRequest.baseRequest
            .add(path: "/orders")
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        
        let jsonEncoder = try? JSONEncoder().encode(cart)
        request.httpBody = jsonEncoder
        
        return networkProvider.request(for: request)
    }
    
    func updateProducts(with cart: [CartProduct]) -> AnyPublisher<Void, Error> {
        var request = URLRequest.updateProductsBaseRequest
        request.httpMethod = "POST"

        let data = try? JSONEncoder().encode(cart)
        request.httpBody = data
        
        let jsonString = String(data: data ?? Data(), encoding: .utf8)!
        print(jsonString)
        return  networkProvider.updateProductRequest(for: request)
    }
}
