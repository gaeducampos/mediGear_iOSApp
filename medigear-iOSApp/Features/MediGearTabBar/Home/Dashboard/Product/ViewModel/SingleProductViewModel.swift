//
//  ProductViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/4/23.
//

import Foundation
import Combine

final class SingleProductViewModel: ObservableObject {
    
    let productHomeSubject = PassthroughSubject<Product, Never>()
    let dismissSearchController = PassthroughSubject<Bool, Never>()
    
    
    
}
