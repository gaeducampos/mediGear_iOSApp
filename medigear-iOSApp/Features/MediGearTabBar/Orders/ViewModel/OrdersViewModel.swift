//
//  OrderViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import Foundation
import Combine

final class OrdersViewModel: ObservableObject {
    private let service: OrderService
    private var userOrdersCacellable: AnyCancellable?
    private var userPDFCancellable: AnyCancellable?
    
    var orderDetailSubject = PassthroughSubject<Order, Never>()
    var ordersPDFSubject = PassthroughSubject<Void, Never>()
    
    @Published var isButtonPDFHidden = true
    @Published var userOrders: [Order] = []
    @Published var orderDetails: [OrderDetails] = []
    @Published var isLoading = false
    var orderPDFBase64: OrderPDF?
    
    
    init(service: OrderService) {
        self.service = service
    }
    
    func getUserId() -> Int {
        if let userData = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            let userSession = try? JSONDecoder().decode(Session.self, from: userData)
            guard let userSession = userSession else {return 0}
            return userSession.user.id
        } else {
            return 0
        }
    }
    
    func getOrderDetails() -> [OrderDetails] {
        for userOrder in userOrders {
            self.orderDetails = userOrder.orderDetails
        }
        return orderDetails
    }
    
    func getUserOrdersCompleted() {
        userOrdersCacellable = service
            .getUserOrdersCompleted(with: getUserId())
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let userOrders):
                    if userOrders.isEmpty {
                        self?.isButtonPDFHidden = true
                    } else {
                        self?.isButtonPDFHidden = false
                        self?.userOrders = userOrders
                    }
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    
    func getUserOrdersActive() {
        userOrdersCacellable = service
            .getUserOrdersActive(with: getUserId())
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let userOrders):
                    self?.userOrders = userOrders
                    
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    
    func getUserOrdersPending() {
        userOrdersCacellable = service
            .getUserOrdersPending(with: getUserId())
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let userOrders):
                    self?.userOrders = userOrders
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    func getUserOrdersPDF() {
        self.isLoading = true
        userPDFCancellable = service
            .getUserOrdersPDF(with: getUserId())
            .toResult()
            .sink { [weak self] result in
                switch result {
                case .success(let userPDF):
                    self?.orderPDFBase64 = userPDF
                    self?.isLoading = false
                    self?.ordersPDFSubject.send()
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    func dateFormatter(for userDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: userDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            let outputString = outputFormatter.string(from: date)
            return outputString // this will print "14/05/2023 16:05"
        } else {
            return ""
        }
    }
    
    
    
    
}
