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
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        

        navigationItem.rightBarButtonItems = [cartIcon]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartIcon.target = self
        cartIcon.action = #selector(cartIconTapped)
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        
    }
    

    @objc func cartIconTapped() {
        viewModel.getTotal()
        self.present(PurchaseViewController(viewModel: self.viewModel), animated: true, completion: nil)
    }
    

    @objc func userIconTapped() {
        // Handle user icon tapped
    }


    
}
