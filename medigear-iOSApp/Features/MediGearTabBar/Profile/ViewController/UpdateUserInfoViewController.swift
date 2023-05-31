//
//  UpdateUserInfoViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import UIKit
import SwiftUI
import Combine

class UpdateUserInfoViewController: ProfileViewController {
    private var cancellables = Set<AnyCancellable>()
    
    lazy var updateUserInfoFormHostingVC: UIHostingController = {
        let updateUserInfo = UIHostingController(rootView: UpdateUserInfoView(viewModel: userViewModel))
        updateUserInfo.view.translatesAutoresizingMaskIntoConstraints = false
        updateUserInfo.view.backgroundColor = .systemBackground
        updateUserInfo.view.overrideUserInterfaceStyle = .light
        return updateUserInfo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(updateUserInfoFormHostingVC)
        view.addSubview(updateUserInfoFormHostingVC.view)
        setUpConstrainst()
        dissmissVC()
    }
    
    private func setUpConstrainst() {
        NSLayoutConstraint.activate([
            updateUserInfoFormHostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            updateUserInfoFormHostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            updateUserInfoFormHostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            updateUserInfoFormHostingVC.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func dissmissVC() {
        userViewModel
            .dismissUserInformationVCSubject
            .sink {
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
            
    }
    
}
