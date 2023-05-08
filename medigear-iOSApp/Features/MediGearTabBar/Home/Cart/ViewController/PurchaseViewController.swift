//
//  PurchaseViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 21/4/23.
//

import UIKit
import SwiftUI

class PurchaseViewController: UIViewController {
    let viewModel: CartViewModel

    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cartView: UIHostingController = {
        let cartView = UIHostingController(rootView: CartView(viewModel: viewModel))
        cartView.view.translatesAutoresizingMaskIntoConstraints = false
        cartView.view.backgroundColor = .systemBackground
        cartView.view.overrideUserInterfaceStyle = .light
        return cartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(cartView)
        view.addSubview(cartView.view)
        setupConstrainst()
        
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            cartView.view.topAnchor.constraint(equalTo: view.topAnchor),
            cartView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cartView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    


    
    

    
    

}
