//
//  OrderDetailView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import SwiftUI
import NukeUI

struct OrderDetailView: View {
    let order: Order
    
    init(order: Order) {
        self.order = order
    }
    
    private func dateFormatter(for userDate: String) -> String {
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
    
    
    private func orderStatus(status: Status) -> String {
        switch status {
        case .pending:
            return "Pendiente"
        case .active:
            return "Activa"
        case .complete:
            return "Completada"
        }
    }
    
    private func colorOrderStatus(status: Status) -> Color {
        switch status {
        case .pending:
            return .red
        case .active:
            return .blue
        case .complete:
            return .green
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("Numero de orden: ")
                Spacer()
                Text("#\(order.orderReference)")
            }
            .padding()
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(.gray)

            HStack {
                Text("Fecha de entrega: ")
                Spacer()
                Text("\(order.deliveryTime)")
            }
            .padding()
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(.gray)
            
            
            
            HStack {
                Text("Fecha de creación de la orden: ")
                Spacer()
                Text("\(dateFormatter(for: order.createdAt))")
            }
            .padding()
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(.gray)
            
            
            HStack {
                Text("Estado de la entrega: ")
                Spacer()
                Text("\(orderStatus(status: order.status))")
                    .foregroundColor(colorOrderStatus(status: order.status))
            }
            .padding()
            

            List(order.orderDetails) { product in
                HStack(spacing: 10) {
                    Divider()
                     .frame(height: 1)
                     .padding(.horizontal, 10)
                     .background(.gray)
                    
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .frame(width: 30, height: 30)
                            .overlay(
                                ZStack {
                                    Text("\(product.quantity)")
                                        .foregroundColor(.white)
                                }
                            )
                        Text(product.product.data.attributes.name)
                            .lineLimit(1)
                    }
                    HStack {
                        LazyImage(url: URL(string: "\(NetworkProvider.Constants.baseLocalHost)\(product.product.data.attributes.img)")) { state in
                            if let image = state.image {
                                image.resizable().aspectRatio(contentMode: .fill)
                            }
                        }
                        .frame(maxWidth: 50, maxHeight: 50)
                        
                        if let price = Double(product.product.data.attributes.price) {
                            Text("$\(String(format: "%.2f", (price * Double(product.quantity))))")
                        }
                    }
                }
            }
            .listStyle(.plain)
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(.gray)
            
            HStack {
                
                Text("Total: ")
                    .foregroundColor(.blue)
                Spacer()
                HStack {
                    Text("$")
                    Text("\(String(format: "%.2f", order.total)) USD")
                }
                .padding(0)
            }
            .padding()
            
        }
        
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let orderDetails: [OrderDetails] = []
        let order = Order(id: UUID(),
                          orderReference: "423850",
                          status: .complete,
                          total: 45.232,
                          deliveryTime: "11/23/2023",
                          orderDetails: orderDetails, location: "", createdAt: "")
        OrderDetailView(order: order)
    }
}
