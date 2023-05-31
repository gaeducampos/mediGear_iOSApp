//
//  UserView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel: UserViewModel
    @ObservedObject var cartViewModel: CartViewModel
    
    init(viewModel: UserViewModel, cartViewModel: CartViewModel) {
        self.viewModel = viewModel
        self.cartViewModel = cartViewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Información General")
                Spacer()
                Button {
                    viewModel.updateUserInformationSubject.send()
                } label: {
                    Image(systemName: "pencil.line")
                }
            }
            .bold()
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
            .padding()
            
            if let user = viewModel.user {
                InfoField(title: "Nombre Completo", value: user.fullName)
                
                InfoField(title: "Correo", value: user.email)
                
                InfoField(title: "Fecha de Creación",
                          value: viewModel.dateFormatter(for: user.createdAt))
                
                InfoField(title: "Fecha de actualización de datos",
                          value: viewModel.dateFormatter(for: user.updatedAt))
                
                
                HStack {
                    Text("Seguridad")
                    Spacer()
                    Button {
                        viewModel.presentResetPasswordSubject.send()
                    } label: {
                        Image(systemName: "pencil.line")
                    }
                }
                .bold()
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
                .padding()
                
                
                InfoField(title: "Contraseña", value: "********")
                
                VStack(alignment: .center) {
                    Button {
                        cartViewModel.emptyCart()
                        cartViewModel.deleteUserData()
                        viewModel.closeSessionSubject.send()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .frame(maxWidth: 200, maxHeight: 50)
                                .foregroundColor(.red)
                            Text("Cerrar Sesión")
                                .foregroundColor(.red)
                        }

                    }
                }

            }
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: .init(service: .init(networkProvider: .init())), cartViewModel: .init(service: .init(networkProvider: .init())))
    }
}
