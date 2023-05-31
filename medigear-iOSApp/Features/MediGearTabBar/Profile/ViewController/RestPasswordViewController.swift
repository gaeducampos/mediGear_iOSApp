//
//  RestPasswordViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import UIKit
import SwiftUI
import Combine


class RestPasswordViewController: ProfileViewController {
    private var resetPasswordCacellables = Set<AnyCancellable>()

    lazy var resetPasswordUIHostingController: UIHostingController = {
        let resetPassword = UIHostingController(rootView: ResetPasswordView(viewModel: userViewModel))
        resetPassword.view.translatesAutoresizingMaskIntoConstraints = false
        resetPassword.view.overrideUserInterfaceStyle = .light
        resetPassword.view.backgroundColor = .systemBackground
        return resetPassword
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(resetPasswordUIHostingController)
        view.addSubview(resetPasswordUIHostingController.view)
        setupConstrainst()
        dismissVC()
    }
    
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            resetPasswordUIHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            resetPasswordUIHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resetPasswordUIHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resetPasswordUIHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func dismissVC() {
        userViewModel
            .dismissResetPasswordVCSubject
            .sink {
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &resetPasswordCacellables)
    }
    

}
