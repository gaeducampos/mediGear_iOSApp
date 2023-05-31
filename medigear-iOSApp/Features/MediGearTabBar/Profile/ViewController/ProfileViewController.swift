//
//  ProfileViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit
import SwiftUI
import Combine

class ProfileViewController: CartViewController {
    let userViewModel = UserViewModel(service: .init(networkProvider: .init()))
    private var cancellables = Set<AnyCancellable>()

    lazy var userHostinController: UIHostingController = {
        let user = UIHostingController(rootView: UserView(viewModel: userViewModel, cartViewModel: viewModel))
        user.view.translatesAutoresizingMaskIntoConstraints = false
        user.view.backgroundColor = .systemBackground
        user.view.overrideUserInterfaceStyle = .light
        return user
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userViewModel.getUserInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        addChild(userHostinController)
        view.addSubview(userHostinController.view)
        setUpConstraints()
        
        userViewModel.getUserInfo()
        presentUpdateInfoVC()
        presentResetPasswordVC()
        closeSession()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            userHostinController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userHostinController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userHostinController.view.topAnchor.constraint(equalTo: view.topAnchor),
            userHostinController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func presentUpdateInfoVC() {
        userViewModel
            .updateUserInformationSubject
            .sink {
                self.navigationController?.pushViewController(
                    UpdateUserInfoViewController(isResetPasswordVCPresented: false),
                    animated: true)
            }
            .store(in: &cancellables)
            
    }
    
    private func presentResetPasswordVC() {
        userViewModel
            .presentResetPasswordSubject
            .sink {
                self.navigationController?.pushViewController(RestPasswordViewController(isResetPasswordVCPresented: false), animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func closeSession() {
        userViewModel
            .closeSessionSubject
            .sink {
                self.userViewModel.email = ""
                self.navigationController?.pushViewController(SignInViewController(), animated: true)
            }
            .store(in: &cancellables)
    }
    
    

}
