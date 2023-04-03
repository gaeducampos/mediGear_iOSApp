//
//  HomeViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let viewModel: MedicalMinistrationViewModel = .init(service: .init(netWorkProvider: .init()))
    lazy var searchBarView: UIHostingController = {
        let searchView = UIHostingController(rootView: HomeView(
            viewModel: viewModel
        )
                                             )
        searchView.view.translatesAutoresizingMaskIntoConstraints = false
        searchView.overrideUserInterfaceStyle = .light
        return searchView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(searchBarView)
        view.addSubview(searchBarView.view)
        setupConstraints()
        
        viewModel.getMedicalManufacturers()
        viewModel.getMedicalSpecialties()
       // viewModel.combineMedicalMinistration()
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBarView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarView.view.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
