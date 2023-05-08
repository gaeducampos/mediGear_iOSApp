//
//  CartViewModel.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 19/4/23.
//

import Foundation
import Combine

final class CartViewModel: ObservableObject {
    private let service: CartService
    private var orderCancellable: AnyCancellable?
    private var orderCancellables = Set<AnyCancellable>()
    
    init(service: CartService) {
        self.service = service
    }
    
    @Published var total = 0.00
    

    func appendToCart(cartProduct: CartProduct) {
        let cartData = UserDefaults.standard.data(forKey: "cart")
        guard let cartData = cartData else { return }
        
        var cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
        cart?.append(cartProduct)
        let encodedData = try? JSONEncoder().encode(cart)
        UserDefaults.standard.set(encodedData, forKey: "cart")
    }
    
    func getCart() -> [CartProduct] {
        let emptyCart: [CartProduct] = []
        
        let cartData = UserDefaults.standard.data(forKey: "cart")
        guard let cartData = cartData else { return emptyCart}
        
        let cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
        guard let cart = cart else {return emptyCart}
        return cart
    }
    
    func getTotal() {
        let cartData = UserDefaults.standard.data(forKey: "cart")
        guard let cartData = cartData else { return }
        let cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
        guard let cart = cart else {return}
        
        cart.forEach { products in
            guard let price = Double(products.product.attributes.price) else {return}
            total += Double(products.quantity) * price
        }
    }
    
    func removeItem(indexSet: IndexSet) {
        let cartData = UserDefaults.standard.data(forKey: "cart")
        guard let cartData = cartData else { return }
        let cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
        guard var cart = cart else {return }
        cart.remove(atOffsets: indexSet)
        let encodedData = try? JSONEncoder().encode(cart)
        UserDefaults.standard.set(encodedData, forKey: "cart")
    }


    func createOrder(total: Double, location: String, userId: Int, deliveryTime: String) {
        let cartData = UserDefaults.standard.data(forKey: "cart")
        guard let cartData = cartData else { return }
        let cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
        guard let cart = cart else {return }
        
        
        let orderDetailsProcess = cart
            .map { products in
                service
                    .createOrderDetails(
                        for: APIPostData(
                            data: CartProductOrderDetails(
                                product: "\(products.product.id)",
                                quantity: products.quantity
                            ),
                            meta: .init()
                        )
                    )
            }
        
        orderCancellable =  Publishers.MergeMany(orderDetailsProcess)
            .collect()
            .flatMap { [service] response -> AnyPublisher<APIPostData<Order>, Error> in
                let orderDetails = response.map { order in
                    return "\(order.data.id)"
                }
                let cart = Cart(total: total,
                                location: location,
                                userId: userId,
                                deliveryTime: deliveryTime,
                                order_details: orderDetails)
                let cartData = APIPostData(data: cart, meta: APIPostData<Cart>.Meta())
                return service
                    .createOrder(for: cartData)
                    .eraseToAnyPublisher()
            }
            .flatMap{ [service] _ -> AnyPublisher<Void, Error> in
                return service
                    .updateProducts(with: cart)
                    .eraseToAnyPublisher()
            }
            .toResult()
            .sink { result in
                switch result {
                case .success(_): break
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
}
