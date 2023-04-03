//
//  RegisterUserViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import Foundation
import Combine
import Navajo_Swift

class RegisterUserViewModel: ObservableObject {
    
    enum PasswordCheck {
        case valid
        case noMatch
        case notStrongEnough
    }
    
    var loggedIn = PassthroughSubject<Void, Never>()
    
    var registerCancellable: AnyCancellable?
    var cancellableSet = Set<AnyCancellable>()
    private let service: SignUpService
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var username  = ""
    @Published var password = ""
    @Published var confirmedPassword = ""
    @Published var isValid = false
    @Published var userInvalidAlert = false
    
    var userSession: Session?
    
    var usernameMessage = ""
    var fullNameMessage = ""
    var emailMessage = ""
    var passwordMessage = ""
    
    
    init(service: SignUpService) {
        self.service = service
        
        isEmailValidPublisher
            .receive(on: RunLoop.main)
            .map { isEmailValid in
                isEmailValid ? "" : "El email no tiene un formato valido"
            }
            .assign(to: \.emailMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        
        isUserNameValidPublisher
            .receive(on: RunLoop.main)
            .map { isValidUsername in
                isValidUsername ? "" : "el nombre de usuario debe tener al menos 3 caracteres"
            }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        isFullNameValidPublisher
            .receive(on: RunLoop.main)
            .map { isValidFullName in
                isValidFullName ? "" : "Tu nombre completo debe tener al menos 4 caracteres"
            }
            .assign(to: \.fullNameMessage, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                case .noMatch:
                    return "Las contraseñas no son iguales"
                case .notStrongEnough:
                    return "contraseña debe tener 8 caracteres y contener al menos un número"
                default:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        
        
        
        
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .dropFirst()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.isValidEmail()
            }
            .eraseToAnyPublisher()
    }
    
    private var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isFullNameValidPublisher: AnyPublisher<Bool, Never> {
        $fullName
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 4
            }
            .eraseToAnyPublisher()
    }
    
    

    
    private var arePassowordEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmedPassword)
            .map { password, confirmedPassword in
                return password == confirmedPassword
            }
            .eraseToAnyPublisher()
    }
    
    private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        $password
            .dropFirst()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return Navajo.strength(ofPassword: input)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
        passwordStrengthPublisher
            .map { strength in
                switch strength {
                case .reasonable, .strong, .veryStrong:
                    return true
                default:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest(arePassowordEqualPublisher, isPasswordStrongEnoughPublisher)
            .map {passwordAreEqual, passwordIsStrongEnough in
                if (!passwordAreEqual) {
                    return .noMatch
                }
                else if (!passwordIsStrongEnough) {
                    return .notStrongEnough
                }
                else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isUserNameValidPublisher, isFullNameValidPublisher, isPasswordValidPublisher, isEmailValidPublisher)
            .map { usernameIsValid, fullnameisValid, passwordIsValid, emailIsValid in
                return emailIsValid && usernameIsValid && fullnameisValid && (passwordIsValid == .valid)
            }
            .eraseToAnyPublisher()
    }
    
    
    func registerUser(user: UserRegister) {
        registerCancellable =
        service
            .registerUser(user: user)
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let user):
                    self?.userSession = user
                    self?.loggedIn.send()
                    // Store To userDefaults
                case .failure(_):
                    self?.userInvalidAlert = true
                }
            }
    }
    
    
}
