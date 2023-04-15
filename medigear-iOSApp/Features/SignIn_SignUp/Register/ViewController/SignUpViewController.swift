//
//  SignUpViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 13/3/23.
//

import UIKit
import SwiftUI
import Combine

class SignUpViewController: UIViewController {
    private let viewModel = RegisterUserViewModel(service: .init(networkProvider: .init()))
    private var cancellables = Set<AnyCancellable>()
    
    lazy var signUp: UIHostingController = {
        let signUpView = UIHostingController(rootView: SignUp(viewModel: .init(service: .init(networkProvider: .init()))))
        signUpView.view.translatesAutoresizingMaskIntoConstraints = false
        signUpView.view.backgroundColor = .systemBackground
        signUpView.overrideUserInterfaceStyle = .light
        return signUpView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        
        addChild(signUp)
        view.addSubview(signUp.view)
        setUpContraints()
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            signUp.view.topAnchor.constraint(equalTo: view.topAnchor),
            signUp.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUp.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUp.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func userLoggedIn() {
        viewModel
            .loggedIn
            .sink {
                self.navigationController?.setViewControllers([MediGearTabBarController()], animated: true)
            }
            .store(in: &cancellables)
            
        
    }


}
