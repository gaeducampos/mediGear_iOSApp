//
//  LogInViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 16/3/23.
//

import Foundation
import Combine

class LogInViewModel: ObservableObject {
    var logInCancellable: AnyCancellable?
    private let service: SignInService
    
    
    let loggedIn = PassthroughSubject<Void, Never>()
    @Published var sessionResponse: Session?
    
    
    init(service: SignInService) {
        self.service = service
    }
    
    func logInUser(user: UserLogin) {
        logInCancellable = service
            .logInUser(user: user)
            .sink(receiveCompletion: { _ in},
                  receiveValue: {[weak self] response in
                self?.loggedIn.send()
               // self?.sessionResponse = response
                // save response to user defaults
            })
    }
    
}
