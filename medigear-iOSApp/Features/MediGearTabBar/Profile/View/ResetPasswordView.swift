//
//  RestPasswordView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import SwiftUI
import Combine

struct ResetPasswordView: View {
    @ObservedObject private var viewModel: UserViewModel
    @State private var presentFormSendedAlert = false
    @State private var presentEmailInvalidAlert = false
    @State private var email = ""
    @State private var userExists = false
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Actualizar Contraseña")
                .bold()
                .font(.system(size: 20))
            
            if viewModel.email.isEmpty {
                Text("Asegurate que tu correo este bien escrito")
                
                FormTextField(sectionText: "Correo",
                              notValidInput: "",
                              textFieldValue: $email)
                .padding(.top)
            } else {
                FormTextField(sectionText: "Correo",
                              notValidInput: "",
                              textFieldValue: $viewModel.email)
                .padding(.top)
                .disabled(true)
            }
            
            
            Button(action: {
                
                
                if !viewModel.email.isEmpty {
                    presentFormSendedAlert = true
                } else {
                    if !email.isValidEmail() {
                        presentEmailInvalidAlert = true
                    } else {
                        viewModel.userExists(with: email)
                        viewModel.userExistsSubject.sink { exists in
                            if exists {
                                presentFormSendedAlert = true
                            } else {
                                userExists = true
                            }
                        }
                        .store(in: &viewModel.cancellables)
                    }
                    
                }
                
               
            }) {
                Text("Enviar Correo")
                    .frame(maxWidth: .infinity, minHeight: 50)
                
                
            }
            .buttonStyle(MediGearButtonStyle(isEnable: true))
            .alert(isPresented: $presentFormSendedAlert) {
                Alert(title: Text("Correo Enviado"), message: Text("Se ha enviado un correo con un formulario para que puedas cambiar la contraseña"), dismissButton: .default(Text("OK"), action: {
                    
                    if !viewModel.email.isEmpty {
                        let emailToReset = EmailToResetPassword(email: viewModel.email)
                        viewModel.resetPassword(for: emailToReset)
                    } else {
                        let emailToReset = EmailToResetPassword(email: email)
                        viewModel.resetPassword(for: emailToReset)
                    }
                    
                }))
            }
            .alert("El correo no es valido", isPresented: $presentEmailInvalidAlert) {
                Button("Ok", role: .cancel) {}
            }
            .alert("El correo no existe en el sistema", isPresented: $userExists) {
                Button("Ok", role: .cancel) {}
            }
        }
        .padding()
        
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: .init(service: .init(networkProvider: .init())))
    }
}
