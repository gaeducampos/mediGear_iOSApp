//
//  SignUpViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 13/3/23.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    
    lazy var signUp: UIHostingController = {
        let signUpView = UIHostingController(rootView: SignUp(service: .init(networkProvider: .init())))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
