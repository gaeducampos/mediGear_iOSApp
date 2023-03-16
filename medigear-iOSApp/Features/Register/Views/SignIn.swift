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
    @State private var email  = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    var presentSignUpViewController: () -> Void
    @State private var image: UIImage? = nil
    var mediGearImageURL = "http://localhost:1337/uploads/Screenshot_2023_03_09_at_7_23_58_AM_aa9264b53e.png?updated_at=2023-03-09T13:24:22.963Z"
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            LazyImage(url: URL(string: mediGearImageURL)) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 200, height: 50)
                
            Text("Ingresar")
            VStack(spacing: 20) {
                
                SingForm(email: email,
                           password: password)
                
                
            
                Button(action: {}) {
                    Text("Iniciar Sesión")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    
                }
                .buttonStyle(MediGearButtonStyle())
                
                
                Button(action: {
                    
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


struct SingForm: View {
    @State  var email: String
    @State  var password: String
    

    
    var body: some View {
        FormTextField(placeHolder: "Ingresa tu correo",
                      textFieldValue: $email)
        
    
            TogglableSecureField("Ingresa tu contraseña",
                                 secureContent: $password,
                                 onCommit: {
                guard !password.isEmpty else { return }
            })

        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil,
                                            from: nil,
                                            for: nil)
        }
        
        Divider()
         .frame(height: 1)
         .padding(.horizontal, 30)
         .background(.gray)
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(presentSignUpViewController: {})
    }
}
