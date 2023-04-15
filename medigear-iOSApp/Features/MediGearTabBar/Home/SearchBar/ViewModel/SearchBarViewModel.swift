//
//  SearchBarViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 10/4/23.
//

import Foundation
import Combine

final class SearchBarViewModel: ObservableObject {
    private var productCancellable: AnyCancellable?
    private let service: ProductService
    
    var textChanges: CurrentValueSubject<String, Never> = .init("")
    @Published var products: [Product] = []
    
    
    init(service: ProductService) {
        self.service = service
        
        getFilteredProductsByName()
        
    }
    
    func getFilteredProductsByName() {
        productCancellable = textChanges
            .dropFirst()
            .removeDuplicates()
            .flatMap { [service] productName in
                service
                    .getFilteredProductsByName(for: productName)
            }
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let product):
                    self?.products = product.data
                case .failure(let error):
                    print("FAILURE \(error)")
                }
                
            }
    }


    
    
    
}
