//
//  ViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import Combine
import UIKit
import SwiftUI

class SignInViewController: UIViewController {
    private let viewModel = LogInViewModel(
            service: .init(networkProvider: .init())
        )
    
    lazy var signIn: UIHostingController = {
        let signInView = UIHostingController(
            rootView: SignIn(
                viewModel: self.viewModel,
                presentSignUpViewController: { self.presentSignUpView() }
            )
        )
        
        signInView.view.translatesAutoresizingMaskIntoConstraints  = false
        signInView.view.backgroundColor = .systemBackground
        signInView.overrideUserInterfaceStyle = .light
        return signInView
    }()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(signIn)
        view.addSubview(signIn.view)
        setUpConstraints()
        loggedIn()
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            signIn.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signIn.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signIn.view.topAnchor.constraint(equalTo: view.topAnchor),
            signIn.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func presentSignUpView() {
        self.navigationController?.show(SignUpViewController(), sender: .none)
    }
    
    
    private func loggedIn() {
            viewModel
            .loggedIn
            .sink {
            
                self.navigationController?.pushViewController(
                    MediGearTabBarController(),
                    animated: true)
            }
            .store(in: &cancellables)
    }
}

