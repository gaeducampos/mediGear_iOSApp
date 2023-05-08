//
//  SingleProductViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/4/23.
//

import UIKit
import SwiftUI

class SingleProductViewController: CartViewController {
    let product: Product
    
    lazy var singleProductView: UIHostingController = {
        let productView = UIHostingController(rootView: SingleProductView(product: product, viewModel: self.viewModel))
        productView.view.translatesAutoresizingMaskIntoConstraints = false
        productView.view.overrideUserInterfaceStyle = .light
        productView.view.backgroundColor = .systemBackground
        return productView
    }()
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(singleProductView)
        view.addSubview(singleProductView.view)
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            singleProductView.view.topAnchor.constraint(equalTo: view.topAnchor),
            singleProductView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            singleProductView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            singleProductView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    

}
