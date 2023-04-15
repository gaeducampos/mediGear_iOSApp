//
//  HomeViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 27/3/23.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    private let searchViewModel = SearchBarViewModel(service: .init(netWorkProvider: .init()))
    private let medicalMinistrationViewModel: MedicalMinistrationViewModel = .init(service: .init(netWorkProvider: .init()))
    private let singleProductViewModel = SingleProductViewModel()
    private var searchController: UISearchController?

    
    lazy var searchBarView: UIHostingController = {
        let searchView = UIHostingController(rootView: DashboardContentView(viewModel: medicalMinistrationViewModel))
        searchView.view.translatesAutoresizingMaskIntoConstraints = false
        searchView.view.backgroundColor = .white
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
        presentProductController()
        presentSingleProductController()
        
        
        medicalMinistrationViewModel.getMedicalManufacturers()
        medicalMinistrationViewModel.getMedicalSpecialties()
        
        searchController = UISearchController(searchResultsController: SearchResultViewController(
            viewModel: searchViewModel,
            singleProductViewModel: singleProductViewModel))
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Buscar"
        self.definesPresentationContext = true
        searchController?.searchBar.searchTextField.addTarget(self, action: #selector(searchResult), for: .editingChanged)
        
        
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "MediGear - Nuestros Productos - "

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "MediGear - Nuestros Productos - "
    }

    @objc private func searchResult(_ textField: UITextField) {
        guard let searchedText = textField.text else {return}
        searchViewModel.textChanges.send(searchedText)
    }
    

    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBarView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarView.view.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func presentProductController() {
        medicalMinistrationViewModel
            .pushToProductVC
            .sink { [weak self] value in
                guard let products = value else { return }
                guard let self = self else {return}
                
                self.navigationController?.pushViewController(
                    ProductListViewController(
                        products: products,
                        singleProductViewModel: self.singleProductViewModel), animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func presentSingleProductController() {
        singleProductViewModel
            .productHomeSubject
            .sink { [weak self] product in
                self?.navigationController?.pushViewController(SingleProductViewController(product: product), animated: true)
            }
            .store(in: &cancellables)
    }

}
