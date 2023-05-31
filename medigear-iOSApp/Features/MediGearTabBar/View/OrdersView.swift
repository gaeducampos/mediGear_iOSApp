//
//  OrderView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 11/5/23.
//

import SwiftUI

struct OrdersView: View {
   @ObservedObject var viewModel: OrdersViewModel
    
    init (viewModel: OrdersViewModel) {
        self.viewModel = viewModel
    }
    
    private func orderStatus(status: Status) -> String {
        if status.rawValue == "s1" {
            return "Pendiente"
        } else if status.rawValue == "s2" {
            return "Activa"
        } else {
            return "Completada"
        }
    }
    
    var body: some View {
        
        
        VStack {
            if viewModel.userOrders.isEmpty {
                Text("No hay Ordenes")
            } else {
                List(viewModel.userOrders) { order in
                    VStack(spacing: 10) {
                        Text("Orden #\(order.orderReference)")
                            .bold()
                        Text(orderStatus(status: order.status))
                        Text("Fecha de Pedido \(viewModel.dateFormatter(for: order.createdAt))")
                        
                        Button(action: {
                            viewModel.orderDetailSubject.send(order)
                        }) {
                            Text("Ver Detalle")
                                .frame(maxWidth: .infinity, minHeight: 30)
                        }
                        .buttonStyle(MediGearButtonStyle(isEnable: true))
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                }
                
                Button(action: {
                    viewModel.getUserOrdersPDF()
                }) {
                    Text("Visualizar Ordernes PDF")
                        .frame(maxWidth: .infinity, minHeight: 50)
                    
                    
                }
                .buttonStyle(MediGearButtonStyle(isEnable: true))
                .opacity(viewModel.isButtonPDFHidden ? 0 : 1)
                .disabled(viewModel.isButtonPDFHidden)
                .padding()
            }
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: .init(service: .init(networkProvider: .init())))
    }
}
