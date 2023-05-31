//
//  SignUp.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 9/3/23.
//

import Nuke
import NukeUI
import SwiftUI
import TogglableSecureField


struct SignIn: View {
    @ObservedObject var viewModel: LogInViewModel
    @State private var email  = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var presentEmailInvalidAlert = false
    @State private var presentFildsRequiredAledt = false
    
    var presentSignUpViewController: () -> Void
    var mediGearImageURL = "\(NetworkProvider.Constants.baseLocalHost)/uploads/Screenshot_2023_03_09_at_7_23_58_AM_aa9264b53e.png?updated_at=2023-03-09T13:24:22.963Z"
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            LazyImage(url: URL(string: mediGearImageURL)) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 200, height: 50)
                
            Text("- Ingresar -")
            VStack(spacing: 20) {
                
                FormTextField(sectionText: "Email", notValidInput: "",
                              textFieldValue: $email)
                
            
                SecureCustomTexField(sectionText: "Contraseña",
                                     notValidInput: "",
                                     password: $password)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil,
                                                    from: nil,
                                                    for: nil)
                }
                
                Button(action: {
                    if email.isEmpty, password.isEmpty {
                        presentFildsRequiredAledt = true
                    }
                    else if !email.isValidEmail() {
                        presentEmailInvalidAlert = true
                    } else {
                        viewModel.logInUser(user: UserLogin(identifier: email, password: password))
                    }
                    
                }) {
                    Text("Iniciar Sesión")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    
                    
                }
                .buttonStyle(MediGearButtonStyle(isEnable: true))
                .alert("Los campos son Obligatorios", isPresented: $presentFildsRequiredAledt) {
                    Button("Ok", role: .cancel) {}
                }
                .alert("Email no tiene formato valido", isPresented: $presentEmailInvalidAlert) {
                    Button("OK", role: .cancel) {}
                }
                .alert("Usuario/Contraseña no valido", isPresented: $viewModel.presentNotUserValidAlert) {
                    Button("OK", role: .cancel) {}
                }
                
                
                Button(action: {
                    viewModel.presenResetPasswordSubject.send()
                }, label: {
                    Text("¿Olvidaste tu contraseña?")
                        .font(.system(size: 14))
                })
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("¿No tienes cuenta?")
                            .foregroundColor(.black)
                        Text("Crea una aquí")
                            .onTapGesture {
                                presentSignUpViewController()
                            }
                    }
                    .font(.caption)
                })
                
            }
            .padding(.all)
            
        }
        
    }
}



struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(viewModel: .init(service: .init(networkProvider: .init())),
               presentSignUpViewController: {})
    }
}
