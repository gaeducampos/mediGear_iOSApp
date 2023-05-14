//
//  MedicalSpecialtiesViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import Foundation
import Combine

class MedicalMinistrationViewModel: ObservableObject {
    private let service: MedicalMinistrationService
    private var medicalSpecialtyCancellable: AnyCancellable?
    private var medicalManufacturerCancellable: AnyCancellable?
    private var medicalMinistrationCancellable: AnyCancellable?
    private var productsBySubCategoryCancellable: AnyCancellable?
    
    let pushToProductVC = PassthroughSubject<[Product]?, Never>()
    
    @Published var medicalSpecialties: [MedicalMinistration] = []
    @Published var medicalManufacturers: [MedicalMinistration] = []
    @Published var productsBySubCategory: [Product] = []
    
    
    init(service: MedicalMinistrationService) {
        self.service = service
    }
    
    func getMedicalSpecialties() {
        medicalSpecialtyCancellable = service
            .getMedicalSpecialties()
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.medicalSpecialties = response.data
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }

    func getMedicalManufacturers() {
        medicalManufacturerCancellable = service
            .getMedicalManufacturers()
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.medicalManufacturers = response.data
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    
    func getFilteredProductsBySubCategory(for subCategory: String) {
        productsBySubCategoryCancellable = service
            .getFilteredProductsBySubCategory(for: subCategory)
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.productsBySubCategory = response.data
                    self?.pushToProductVC.send(response.data)
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
}
