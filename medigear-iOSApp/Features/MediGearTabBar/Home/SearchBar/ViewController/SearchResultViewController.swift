//
//  SearchResultViewController.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/4/23.
//

import UIKit
import SwiftUI
import Combine

class SearchResultViewController: UIViewController {
    let viewModel: SearchBarViewModel
    private let singleProductViewModel: SingleProductViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: SearchBarViewModel, singleProductViewModel: SingleProductViewModel) {
        self.viewModel = viewModel
        self.singleProductViewModel = singleProductViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchResultView: UIHostingController = {
       let searchResult = UIHostingController(rootView: SearchResultView(
        viewModel: viewModel,
        singleProductViewModel: singleProductViewModel))
        searchResult.view.translatesAutoresizingMaskIntoConstraints = false
        searchResult.view.backgroundColor = .systemBackground
        searchResult.view.overrideUserInterfaceStyle = .light
        return searchResult
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.overrideUserInterfaceStyle = .light
        
        addChild(searchResultView)
        view.addSubview(searchResultView.view)
        setupConstraints()

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchResultView.view.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchResultView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
 
    

}
