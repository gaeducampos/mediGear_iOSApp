//
//  OrderViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit
import SwiftUI
import Combine

class OrdersViewController: CartViewController {
    private var ordersCallables = Set<AnyCancellable>()
    let ordersViewModel = OrdersViewModel(service: .init(networkProvider: .init()))
    private let segmentedControl = UISegmentedControl(items: ["Pendientes", "Activas", "Completadas"])
    
    lazy var ordersView: UIHostingController = {
        let orders = UIHostingController(rootView: OrdersView(viewModel: ordersViewModel))
        orders.view.translatesAutoresizingMaskIntoConstraints = false
        orders.view.backgroundColor = .systemBackground
        orders.view.overrideUserInterfaceStyle = .light
        
        return orders
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(ordersView)
        view.addSubview(ordersView.view)
        view.addSubview(segmentedControl)
        setupConstraints()
        ordersViewModel.getUserOrdersPending()
        presentOrderDetailsController()
        presentOrdersPDFController()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ordersView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ordersView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ordersView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ordersView.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
        ])
    }
    
    private func presentOrderDetailsController() {
        ordersViewModel
            .orderDetailSubject
            .sink { order in
                self.navigationController?.pushViewController(OrderDetailsViewController(order: order), animated: true)
            }
            .store(in: &ordersCallables)
    }
    
    
    private func presentOrdersPDFController() {
        ordersViewModel
            .ordersPDFSubject
            .sink {
                guard let userOrderPDF = self.ordersViewModel.orderPDFBase64 else {return}
                self.navigationController?.show(PDFOrderViewController(pdfBase64: userOrderPDF), sender: .none)
            }
            .store(in: &ordersCallables)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle segmented control value changes here
        let selectedIndex = sender.selectedSegmentIndex
        // Update your SwiftUI view based on the selected index
       
        switch selectedIndex {
        case 0:
            ordersViewModel.getUserOrdersPending()
            ordersViewModel.isButtonPDFHidden = true
        case 1:
            ordersViewModel.getUserOrdersActive()
            ordersViewModel.isButtonPDFHidden = true
        case 2:
            ordersViewModel.getUserOrdersCompleted()
        default:
            break
        }
    }
    
}


