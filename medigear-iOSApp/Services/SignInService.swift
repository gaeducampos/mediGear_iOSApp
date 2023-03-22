//
//  SignInService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 16/3/23.
//

import Foundation
import Combine

class SignInService {
    private let networkProvider: NetworkProvider
    
    @Published var sessionResponse: Session?
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    
    func logInUser(user: UserLogin) -> AnyPublisher<Session, Error> {
        
        var request = URLRequest.baseRequest
        request.url?.append(path: "/auth/local")
        request.httpMethod = "POST"
        let jsonEncoder = try? JSONEncoder().encode(user)
        request.httpBody = jsonEncoder
        
        return networkProvider.request(for: request)
            
    }
}
