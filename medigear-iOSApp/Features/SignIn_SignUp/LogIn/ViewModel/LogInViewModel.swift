//
//  LogInViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 16/3/23.
//

import Foundation
import Combine

final class LogInViewModel: ObservableObject {
    var logInCancellable: AnyCancellable?
    private let service: SignInService
    
    let presenResetPasswordSubject = PassthroughSubject<Void, Never>()
    
    
    @Published var presentNotUserValidAlert = false
    
    
    let loggedIn = PassthroughSubject<Void, Never>()
    @Published var sessionResponse: Session?
    
    
    init(service: SignInService) {
        self.service = service
    }
    

    
    func logInUser(user: UserLogin) {
        logInCancellable = service
            .logInUser(user: user)
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let user):
                    let encondedUserInfo = try? JSONEncoder().encode(user)
                    UserDefaults.standard.set(encondedUserInfo, forKey: "userInfo")
                    
                    self?.loggedIn.send()
                case .failure(_):
                    self?.presentNotUserValidAlert = true
                }
            }
    }
    
}
