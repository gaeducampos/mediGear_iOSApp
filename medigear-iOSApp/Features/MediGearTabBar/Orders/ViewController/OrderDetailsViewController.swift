//
//  OrderDetailsViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import UIKit
import SwiftUI

class OrderDetailsViewController: UINavigationController {
    let order: Order
    
    lazy var orderDetailsUIHostinController: UIHostingController  = {
        let orderDetails = UIHostingController(rootView: OrderDetailView(order: order))
        orderDetails.view.translatesAutoresizingMaskIntoConstraints = false
        orderDetails.view.overrideUserInterfaceStyle = .light
        orderDetails.view.backgroundColor = .systemBackground
        return orderDetails
    }()
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(orderDetailsUIHostinController)
        view.addSubview(orderDetailsUIHostinController.view)
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            orderDetailsUIHostinController.view.topAnchor.constraint(equalTo: view.topAnchor),
            orderDetailsUIHostinController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderDetailsUIHostinController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orderDetailsUIHostinController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
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
