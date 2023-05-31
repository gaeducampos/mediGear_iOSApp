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
    
    var orderCreatedSubject = PassthroughSubject<Void, Never>()
    
    @Published var orderCreatedAlert = false
    @Published var location = ""
    
    init(service: CartService) {
        self.service = service
    }
    
    @Published var total = 0.00
    
    
    func appendToCart(cartProduct: CartProduct) {
        let cartData = UserDefaults.standard.data(forKey: "cart") ?? Data()
        
        var cart = (try? JSONDecoder().decode([CartProduct].self, from: cartData)) ?? []
        cart.append(cartProduct)
        let encodedData = try? JSONEncoder().encode(cart)
        UserDefaults.standard.set(encodedData, forKey: "cart")
    }
    
    func getCart() -> [CartProduct] {
        let cartData = UserDefaults.standard.data(forKey: "cart") ?? Data()
        return (try? JSONDecoder().decode([CartProduct].self, from: cartData)) ?? []
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
    
    func emptyCart() {
        location = ""
        UserDefaults.standard.set(location, forKey: "userLocation")
        
        total = 0.00
        
        if let cartData = UserDefaults.standard.object(forKey: "cart") as? Data {
            var cart = try? JSONDecoder().decode([CartProduct].self, from: cartData)
            cart?.removeAll()
            guard let cart = cart else {return}
            let encodedCartData = try? JSONEncoder().encode(cart)
            UserDefaults.standard.set(encodedCartData, forKey: "cart")
        }
        
    }
    
    func deleteUserData() {
        if let userData = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            let userSession = try? JSONDecoder().decode(Session.self, from: userData)
            guard var userSession = userSession else {return}
            
            userSession = Session(jwt: "", user: User(id: -1,
                                                      username: "",
                                                      email: "",
                                                      provider: "",
                                                      confirmed: false,
                                                      blocked: false,
                                                      createdAt: "",
                                                      updatedAt: "",
                                                      fullName: ""))
            
            let encondedUserData = try? JSONEncoder().encode(userSession)
            UserDefaults.standard.set(encondedUserData, forKey: "userInfo")
        }
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
    
    func getUser() -> User? {
        if let userData = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            let userSession = try? JSONDecoder().decode(Session.self, from: userData)
            guard let userSession = userSession else {return nil}
            return userSession.user
        } else {
            return nil
        }
    }
    
    
    func createOrder(total: Double, location: String, deliveryTime: String) {
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
            .flatMap { [weak self, service] response -> AnyPublisher<APIPostData<OrderResponse>, Error> in
                
                let orderDetails = response.map { order in
                    return "\(order.data.id)"
                }
                
                guard let userId = self?.getUserId() else {
                    let error = NSError(domain: "mediGear.ios.App", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "User ID is missing"])
                    return Fail(error: error).eraseToAnyPublisher()
                }
                
                let cart = Cart(total: total,
                                location: location,
                                userId: userId,
                                deliveryTime: deliveryTime,
                                order_details: orderDetails,
                                status: .pending)
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
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(_):
                    self?.orderCreatedAlert = true
                case .failure(let error):
                    print("Failure \(error)")
                }
            }
    }
    
    
}
