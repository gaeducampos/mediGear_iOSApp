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
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var username = ""
    @State var fullName = ""
    @State var isPasswordVissible = false
    
    init(service: SignUpService) {
        _viewModel = StateObject(wrappedValue: RegisterUserViewModel(service: service))
    }
    
    let mediGearImageLogoURL = "http://localhost:1337/uploads/Screenshot_2023_03_09_at_7_23_58_AM_aa9264b53e.png?updated_at=2023-03-09T13:24:22.963Z"
    
    var body: some View {
        VStack(spacing: 25) {
            LazyImage(url: URL(string: mediGearImageLogoURL)) {state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 200, height: 50)
            
            VStack(spacing: 15) {
                FormTextField(placeHolder: "Ingresa Tu Nombre y Apellido",
                              textFieldValue: $fullName)
                FormTextField(placeHolder: "Ingresa tu email",
                              textFieldValue: $email)
                FormTextField(placeHolder: "Ingresa un Nombre de usuario",
                              textFieldValue: $username)
                TogglableSecureField("Ingresa tu contraseña",
                                     secureContent: $password,
                                     onCommit: {
                    guard !password.isEmpty else { return }
                })
                Divider()
                 .frame(height: 1)
                 .padding(.horizontal, 10)
                 .background(.gray)
                TogglableSecureField("Confirma tu contraseña",
                                     secureContent: $confirmPassword,
                                     onCommit: {
                    guard !password.isEmpty else { return }
                })
                Divider()
                 .frame(height: 1)
                 .padding(.horizontal, 10)
                 .background(.gray)
                
                
                Button(action: {
                    viewModel.registerUser(user: UserRegister(email: email,
                                                              password: password,
                                                              username: username,
                                                              fullName: fullName))
                }) {
                    Text("Crear Cuenta")
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .buttonStyle(MediGearButtonStyle())
            }
            
        }
        .padding(.all)
    }
}


struct SignUpForm: View {
    @State var email: String
    @State var password: String
    @State var username: String
    @State var name: String
    @State var lastName: String
    @State var isPasswordVissible: Bool
    

    
    var body: some View {
        VStack(spacing: 15) {
            
        }
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(service: SignUpService(networkProvider: .init()))
    }
}
