//
//  ViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import UIKit
import SwiftUI

class SignInViewController: UIViewController {
        
    lazy var signIn: UIHostingController = {
        let signInView = UIHostingController(rootView: SignIn(presentSignUpViewController: { self.presentSignUpView() }))
        signInView.view.translatesAutoresizingMaskIntoConstraints  = false
        signInView.view.backgroundColor = .systemBackground
        signInView.overrideUserInterfaceStyle = .light
        return signInView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(signIn)
        view.addSubview(signIn.view)
        setUpConstraints()
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
    
    


}

