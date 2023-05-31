//
//  CartViewIconsController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 21/4/23.
//

import UIKit
import Combine

class CartViewController: UIViewController {
    let viewModel = CartViewModel(service: .init(networkProvider: .init()))
    let presentCartVCSubject = PassthroughSubject<Void, Never>()
    
    
    let cartIcon = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: nil, action: nil)
    var isResetPasswordVCPresented: Bool

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isResetPasswordVCPresented {
            navigationItem.rightBarButtonItems = []
        } else {
            navigationItem.rightBarButtonItems = [cartIcon]
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartIcon.target = self
        cartIcon.action = #selector(cartIconTapped)
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        
    }
    
    init(isResetPasswordVCPresented: Bool) {
        self.isResetPasswordVCPresented = isResetPasswordVCPresented
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func cartIconTapped() {
        viewModel.getTotal()
        let purchaseVC = UINavigationController(rootViewController: PurchaseViewController(viewModel: self.viewModel))
        self.present(purchaseVC, animated: true, completion: nil)
    }
    

    @objc func userIconTapped() {
        // Handle user icon tapped
    }
    


    
}
