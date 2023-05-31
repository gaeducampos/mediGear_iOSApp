//
//  UpdateUserInfoView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import SwiftUI

struct UpdateUserInfoView: View {
    @State private var presentFildsRequiredAledt = false
    @State private var presentEmailInvalidAlert = false
    @State private var presentEmailOrUserTakenAlert = false
    @State private var presentInformationUpdatedAlert = false
    @ObservedObject private var viewModel: UserViewModel
    
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Actualizar Información")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            FormTextField(sectionText: "Nombre completo",
                          notValidInput: "",
                          textFieldValue: $viewModel.fullName)
            
            FormTextField(sectionText: "Nombre de usuario",
                          notValidInput: "",
                          textFieldValue: $viewModel.userName)
            
            FormTextField(sectionText: "Email",
                          notValidInput: "",
                          textFieldValue: $viewModel.email)
            
            Button(action: {
                if viewModel.fullName.isEmpty,
                   viewModel.email.isEmpty,
                   viewModel.userName.isEmpty {
                    presentFildsRequiredAledt = true
                }
                else if !viewModel.email.isValidEmail() {
                    presentEmailInvalidAlert = true
                }
                else if viewModel.emailOrUserAlredyTakenAlert {
                    presentEmailOrUserTakenAlert = true
                } else {
                    if let user = viewModel.user {
                        let updatedUser = User(id: user.id,
                                        username: viewModel.userName,
                                        email: viewModel.email,
                                        provider: user.provider,
                                        confirmed: user.confirmed,
                                        blocked: user.blocked,
                                        createdAt: user.createdAt,
                                        updatedAt: user.updatedAt,
                                        fullName: viewModel.fullName)
                        
                        viewModel.updateUser(user: updatedUser)
                        
                        presentInformationUpdatedAlert = true
                    }
                }
                
            }) {
                Text("Actualizar Datos")
                .frame(maxWidth: .infinity, minHeight: 50)
                
                
            }
            .buttonStyle(MediGearButtonStyle(isEnable: true))
            .alert("Los campos son Obligatorios", isPresented: $presentFildsRequiredAledt) {
                Button("Ok", role: .cancel) {}
            }
            .alert("Email no tiene formato valido", isPresented: $presentEmailInvalidAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Nombre de usuario o email en uso", isPresented: $presentEmailOrUserTakenAlert) {
                Button("OK", role: .cancel) {}
            }
            .alert("Usuario actualizado con exito", isPresented: $presentInformationUpdatedAlert) {
                Button("OK", role: .cancel) {
                    viewModel.dismissUserInformationVCSubject.send()
                }
            }
        }
        .padding()
    }
}

struct UpdateUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 23,
                        username: "Galopez",
                        email: "galopez@gmail.com",
                        provider: "local",
                        confirmed: true,
                        blocked: false,
                        createdAt: "2023-05-08T16:42:17.729Z",
                        updatedAt: "2023-05-14T16:05:44.608Z",
                        fullName: "Gabriel Lopez")
        UpdateUserInfoView(viewModel: .init(service: .init(networkProvider: .init())))
    }
}
