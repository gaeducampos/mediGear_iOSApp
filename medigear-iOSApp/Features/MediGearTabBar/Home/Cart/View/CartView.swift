//
//  CartView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 21/4/23.
//

import SwiftUI
import NukeUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    @State private var selectedDate = Date.now
    @State private var showAlert = false
    @State private var location = ""
    @State private var dateString = ""
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateString = dateFormatter.string(from: selectedDate)
        return dateString
    }

    private func getTotalProduct(price: String, quantity: Int) -> Double {
        guard let price = Double(price) else { return 0.00}
        let quantityProducts = Double(quantity)
        return quantityProducts * price
    }
    
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Dirección")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                    .padding(.bottom)
                TextField("", text: $viewModel.location, onEditingChanged: { isEditing in
                    if !isEditing {
                        UserDefaults.standard.set(viewModel.location, forKey: "userLocation")
                    }
                })
                Divider()
                 .frame(height: 1)
                 .background(.gray)
            }

            
            HStack  {
                Text("Fecha y Hora")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                Spacer()
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: Date.now...)
                .labelsHidden()
            }
            
            Divider()
             .frame(height: 1)
             .background(.gray)
            
            List {
                ForEach(viewModel.getCart()) { product in
                    HStack {
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
                            Text(product.product.attributes.name)
                                .lineLimit(1)
                        }
                        HStack {
                            LazyImage(url: URL(string: "\(NetworkProvider.Constants.baseLocalHost)\(product.product.attributes.img)")) { state in
                                if let image = state.image {
                                    image.resizable().aspectRatio(contentMode: .fill)
                                }
                            }
                            .frame(maxWidth: 50, maxHeight: 50)
                            
                            Text("$\(String(format: "%.2f", getTotalProduct(price: product.product.attributes.price, quantity: product.quantity)))")
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.removeItem(indexSet: indexSet)
                    viewModel.total = 0.00
                    viewModel.getTotal()
                }
            }
            .listStyle(PlainListStyle())
            
            HStack {
                HStack {
                    Text("Método de pago")
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(""),
                              message: Text("Si tú selección de pago es con tarjeta de credito.  Nosotros llevaremos el POS hasta tú domilicio.\n\n Todos los pagos son contra entrega."),
                              dismissButton: .default(Text("Ok"))
                        )
                    }
                }
                Spacer()
                Menu {
                    Button("Tarjeta de credito") {
                        print("")
                    }

                    Button("Cheque") {
                        print("")
                    }
                } label: {
                    Label("Opciones", systemImage: "dollarsign")
                        
                }
            }
            .frame(maxWidth: .infinity)
            
            Divider()
             .frame(height: 1)
             .background(.gray)
             .padding(.bottom)
            
            
            HStack {
                Text("Total a pagar:")
                Spacer()
                Text("$\(String(format: "%.2f", viewModel.total)) USD")
            }
            .frame(maxWidth: .infinity)
            
            
            Button {
                viewModel.createOrder(total: viewModel.total,
                                      location: location,
                                      deliveryTime: getDate())
            } label: {
                Text("Ordenar")
                    .frame(maxWidth: .infinity, minHeight: 50)
            }
            .buttonStyle(MediGearButtonStyle(isEnable: true))
            .alert("Orden Creada con exito", isPresented: $viewModel.orderCreatedAlert) {
                Button("Ok", role: .cancel) {
                    viewModel.emptyCart()
                    viewModel.orderCreatedSubject.send()
                }
            }
        }
        .padding()
        .onAppear {
            if let userLocation = UserDefaults.standard.string(forKey: "userLocation") {
                location = userLocation
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel(service: .init(networkProvider: .init())))
    }
}
