//
//  SignUp.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI
import NukeUI
import TogglableSecureField

struct SignUp: View {
    @StateObject var viewModel: RegisterUserViewModel
    
    
    init(service: SignUpService) {
        _viewModel = StateObject(wrappedValue: RegisterUserViewModel(service: service))
    }
    
    let mediGearImageLogoURL = "http://localhost:1337/uploads/Screenshot_2023_03_09_at_7_23_58_AM_aa9264b53e.png?updated_at=2023-03-09T13:24:22.963Z"
    
    var body: some View {
        VStack(spacing: 25) {
            LazyImage(url: URL(string: mediGearImageLogoURL)) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 200, height: 50)
            
            VStack(spacing: 15) {
                FormTextField(sectionText: "Nombre completo",
                              notValidInput: viewModel.fullNameMessage,
                              textFieldValue: $viewModel.fullName)
                FormTextField(sectionText: "Email",
                              notValidInput: viewModel.emailMessage,
                                  textFieldValue: $viewModel.email)
                FormTextField(sectionText: "Nombre de usuario",
                              notValidInput: viewModel.usernameMessage,
                                  textFieldValue: $viewModel.username)
                SecureCustomTexField(sectionText: "Contraseña",
                                     notValidInput: viewModel.passwordMessage,
                                     password: $viewModel.password)
                SecureCustomTexField(sectionText: "Confirmar Contraseña",
                                     notValidInput: viewModel.passwordMessage,
                                     password: $viewModel.confirmedPassword)
                

                Button(action: {
                    viewModel.registerUser(user: UserRegister(email: viewModel.email,
                                                              password: viewModel.password,
                                                              username: viewModel.username,
                                                              fullName: viewModel.fullName))
        
                
                    
                }) {
                    Text("Crear Cuenta")
                        .frame(maxWidth: .infinity, minHeight: 50)
                
                }
                .buttonStyle(MediGearButtonStyle(isEnable: viewModel.isValid))
                .alert("El usuario ya existe o Email ya existe", isPresented: $viewModel.showAlert) {
                    Button("Ok", role: .cancel) {}
                }
                
            }
            .padding(.all)
        }
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(service: SignUpService(networkProvider: .init()))
    }
}
