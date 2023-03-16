//
//  RegisterUserViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import Foundation
import Combine

class RegisterUserViewModel: ObservableObject {
    var registerCancellable: AnyCancellable?
    private let service: SignUpService
    
    @Published var userSession: Session?
    @Published var userRegister: UserRegister?
    
    init(service: SignUpService) {
        self.service = service
    }
    
    func registerUser(user: UserRegister) {
        registerCancellable =
        service
            .registerUser(user: user)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                self?.userSession = response
                print(response)
            })
    }
    
    
}
