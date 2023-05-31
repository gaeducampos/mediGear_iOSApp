//
//  UserViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import Foundation
import Combine


final class UserViewModel: ObservableObject {
    private let service: UserService
    private var userUpdateCancellable: AnyCancellable?
    private var userInfoCancellable: AnyCancellable?
    private var userResetPasswordCancellable: AnyCancellable?
    private var userExistsCancellable: AnyCancellable?
    
    var userExists: Bool?
    var cancellables = Set<AnyCancellable>()
    
    @Published var user: User?
    @Published var email = ""
    @Published var fullName = ""
    @Published var userName = ""
    @Published var emailOrUserAlredyTakenAlert = false
    
    let updateUserInformationSubject = PassthroughSubject<Void, Never>()
    let presentResetPasswordSubject = PassthroughSubject<Void, Never>()
    let closeSessionSubject = PassthroughSubject<Void, Never>()
    
    let dismissUserInformationVCSubject = PassthroughSubject<Void, Never>()
    let dismissResetPasswordVCSubject = PassthroughSubject<Void, Never>()
    let userExistsSubject = PassthroughSubject<Bool, Never>()
    
    
    init(service: UserService) {
        self.service = service
    }
    
    func updateUser(user: User) {
        userUpdateCancellable = service
            .updateUser(for: user)
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.emailOrUserAlredyTakenAlert = true
                    print("Failure \(error)")
                }
            }
    }
    
    func getUserInfo() {
        userInfoCancellable = service
            .getUserInfo(for: self.getUserId())
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.email = user.email
                    self?.fullName = user.fullName
                    self?.userName = user.username
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    func resetPassword(for email: EmailToResetPassword) {
        userResetPasswordCancellable = service
            .resetPassword(for: email)
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(_):
                    self?.dismissResetPasswordVCSubject.send()
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    
    func userExists(with email: String){
        userExistsCancellable = service
            .userExists(with: email)
            .toResult()
            .sink { result in
                switch result {
                case .success(let user):
                    if user.isEmpty {
                        self.userExistsSubject.send(false)
                    } else {
                        self.userExistsSubject.send(true)
                    }
                case .failure(let error):
                    print("Faiulure \(error)")
                }
            }
    }
    
    
    func dateFormatter(for userDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: userDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            let outputString = outputFormatter.string(from: date)
            return outputString // this will print "14/05/2023 16:05"
        } else {
            return ""
        }
    }
    
    
    
    func getUserId() -> Int {
        if let userData = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            let userSession = try? JSONDecoder().decode(Session.self, from: userData)
            guard let userSession = userSession else {return 0}
            return userSession.user.id
        } else {
            return 0
        }
    }
    
    
}


