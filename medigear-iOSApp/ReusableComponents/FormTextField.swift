//
//  FormTextField.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI

struct FormTextField: View {
    var placeHolder: String
    @Binding var textFieldValue: String

    
    var body: some View {
        TextField(placeHolder, text: $textFieldValue)
        
        
        Divider()
         .frame(height: 1)
         .padding(.horizontal, 10)
         .background(.gray)
    }
}

//struct FormTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        FormTextField(placeHolder: "Ingresa tu contraseña",
//                      textFieldValue: $"hi")
//    }
//}


