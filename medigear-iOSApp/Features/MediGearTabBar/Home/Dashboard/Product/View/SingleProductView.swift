//
//  SingleProductView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/4/23.
//

import SwiftUI
import NukeUI

struct SingleProductView: View {
    
    @State private var showingAlert = false
    @State private var quantity = 1
    @State private var isMinusButtonDisable = true
    @State private var isPlusButtonDisable: Bool
    
    
    private func disableMinusButton() {
        if quantity <= 1 || product.attributes.amount == 0 {
            isMinusButtonDisable = true
        } else {
            isMinusButtonDisable = false
        }
    }
    
    private func disablePlusButton(productQuantity: Int) {
        if quantity >= productQuantity || product.attributes.amount == 0  {
            isPlusButtonDisable = true
        } else {
            isPlusButtonDisable = false
        }
    }
    
    let product: Product
    let viewModel: CartViewModel
    
    init(product: Product, viewModel: CartViewModel) {
        self.product = product
        self.viewModel = viewModel
        
        
        if product.attributes.amount == 0 {
            self.isPlusButtonDisable = true
        } else {
            self.isPlusButtonDisable = false
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                LazyImage(url: URL(string: "\(NetworkProvider.Constants.baseLocalHost)\(product.attributes.img)")) { state in
                    if let image = state.image {
                        image.resizable().aspectRatio(contentMode: .fill)
                    }
                }
                .frame(maxWidth: 250, maxHeight: 250)
                Text(product.attributes.name)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Precio Unitario")
                            .font(.system(size: 14))
                        

                        Text("$\(product.attributes.price) \(product.attributes.currency)")
                        
                        if product.attributes.amount == 0 {
                            Text("No hay stock")
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("cantidad")
                            .font(.system(size: 14))
                        HStack {
                            Button {
                                quantity -= 1
                                disableMinusButton()
                                disablePlusButton(productQuantity: product.attributes.amount)
                            } label: {
                                Image(systemName: "minus.square")

                            }
                            .disabled(isMinusButtonDisable)
                            
                            Text("\(quantity)")
                                .font(.system(size: 15))
                            
                            Button {
                                quantity += 1
                                disableMinusButton()
                                disablePlusButton(productQuantity: product.attributes.amount)
                            } label: {
                                Image(systemName: "plus.square")
                            }
                            .disabled(isPlusButtonDisable)
                            
                        }
                        
                    }
                    
                }
                Button {
                    
                    viewModel.appendToCart(cartProduct: CartProduct(product: product, quantity: quantity))
                    showingAlert = true
                    
                } label: {
                    Text("Agregar al carrito")
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .buttonStyle(MediGearButtonStyle(isEnable: product.attributes.amount == 0 ? false : true))
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(""),
                        message: Text("Producto Agregado al carrito"),
                        dismissButton: .default(Text("OK")))
                }
                .disabled(product.attributes.amount == 0 ? true : false)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                    .background(.gray)
                
                
                
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("Descripción")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text(product.attributes.description)
                    .font(.system(size: 14))
                Text("Serial Number")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text(product.attributes.serial_number)
                    .font(.system(size: 14))
            }
            .padding(.bottom)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Ancho:")
                            .foregroundColor(.gray)
                        Text(product.attributes.dimensions.width)
                    }
                    HStack {
                        Text("Alto:")
                            .foregroundColor(.gray)
                        Text(product.attributes.dimensions.height)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Profundidad:")
                            .foregroundColor(.gray)
                        Text(product.attributes.dimensions.depth)
                    }
                    HStack {
                        Text("Peso:")
                            .foregroundColor(.gray)
                        Text(product.attributes.dimensions.weight)
                    }
                }
            }
            .font(.system(size: 14))
            
        }
        .padding()
    }
    
}

struct SingleProductView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel(service: .init(networkProvider: .init()))
        SingleProductView(product: Product(
            id: 10,
            attributes: ProductAttributes(
                name: "OLYMPUS CV-160 VIDEO SISTEMA DE ENDOSCOPÍA",
                description: "Procesador de video Olympus CV-160 Fuente de luz de xenón Olympus CLV-160 Videogastroscopio Olympus GIF-160 Videocolonoscopio Olympus CF-Q160L Nuevo monitor a color de pantalla plana de 22” Pinzas de biopsia y cepillo de limpieza Probador de fugas GRATIS",
                serial_number: "857485521",
                createdAt: "2023-04-08T19:31:58.369Z",
                updatedAt: "2023-04-08T19:31:58.369Z",
                publishedAt: "2023-04-08T19:31:58.369Z",
                dimensions: ProductDimensions(
                    width: "39 cm",
                    height: "147 cm",
                    depth: "32 cm",
                    weight: "29 kg"),
                price: "21.900",
                currency: "USD",
                date_added: "2023-04-08T19:31:58.369Z",
                amount: 23,
                isAvailable: true,
                img: "/uploads/endos1_31917d0e6c.png",
                sub_category: nil)),
                viewModel: viewModel)
    }
}
