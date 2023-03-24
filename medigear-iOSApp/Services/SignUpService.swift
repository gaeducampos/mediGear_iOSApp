//
//  SignUpService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import Foundation
import Combine


class SignUpService {
    private let networkProvider: NetworkProvider
    

    
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    
    func registerUser(user: UserRegister) -> AnyPublisher<Session, Error> {
        var request = URLRequest.baseRequest
        request.setValue("Bearer \(NetworkProvider.BearerToken)", forHTTPHeaderField: "Authorization")
        request.url?.append(path: "/auth/local/register")
        request.httpMethod = "POST"
        let jsonEncoder = try? JSONEncoder().encode(user)
        request.httpBody = jsonEncoder
        
        return networkProvider.request(for: request)
        
    }
    
}

extension Publisher where Failure: Error {
    func toResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        map {
            Result.success($0)
        }
        .catch {
            Just(Result.failure($0))
        }
        .eraseToAnyPublisher()
    }
}
