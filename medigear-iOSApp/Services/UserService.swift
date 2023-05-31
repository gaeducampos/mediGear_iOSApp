//
//  UpdateUserService.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import Foundation
import Combine

final class UserService {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func getUserInfo(for userId: Int) -> AnyPublisher<User, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/users/\(userId)")
        
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return networkProvider.request(for: request)
    }
    
    func updateUser(for user: User) -> AnyPublisher<User, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/users/\(user.id)")
        
        request.httpMethod = "PUT"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        let encondedUserData = try? JSONEncoder().encode(user)
        request.httpBody = encondedUserData
        
        return networkProvider.request(for: request)
        
    }
    
    func userExists(with email: String) -> AnyPublisher<[User], Error> {
        var request = URLRequest.baseRequest
            .add(path: "/users/")
            .addParameters(value: email, name: "filters[$and][0][email][$eq]")
        
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        return networkProvider.request(for: request)
    }
    
    func resetPassword(for email: EmailToResetPassword) -> AnyPublisher<ForgotPasswordResponse, Error> {
        var request = URLRequest.baseRequest
            .add(path: "/auth/forgot-password")
        
        request.httpMethod = "POST"
        request.setValue(
            "Bearer \(NetworkProvider.BearerToken)",
            forHTTPHeaderField: "Authorization")
        
        let encondedUserEmail = try? JSONEncoder().encode(email)
        request.httpBody = encondedUserEmail
        
        return networkProvider.request(for: request)
        
    }
}
