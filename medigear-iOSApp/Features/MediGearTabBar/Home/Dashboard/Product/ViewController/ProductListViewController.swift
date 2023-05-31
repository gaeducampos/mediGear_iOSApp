//
//  ProductViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/4/23.
//

import UIKit
import SwiftUI

class ProductListViewController: CartViewController {
    let products: [Product]
    let singleProductViewModel: SingleProductViewModel
    
    init(
        products: [Product],
        singleProductViewModel: SingleProductViewModel) {
        self.products = products
        self.singleProductViewModel = singleProductViewModel
        super.init(isResetPasswordVCPresented: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var productView: UIHostingController = {
        let product = UIHostingController(rootView: ProductListView(
            products: products,
            singleProductViewModel: singleProductViewModel))
        product.view.translatesAutoresizingMaskIntoConstraints = false
        product.view.backgroundColor = .systemBackground
        product.overrideUserInterfaceStyle = .light
        return product
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(productView)
        view.addSubview(productView.view)
        setupConstraints()
        
        // navigationItem.title = products[0].attributes.sub_category?.data.attributes.name
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationItem.rightBarButtonItems = cartButtonItems
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productView.view.topAnchor.constraint(equalTo: view.topAnchor),
            productView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    



}
