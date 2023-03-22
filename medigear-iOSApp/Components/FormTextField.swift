//
//  FormTextField.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI

struct FormTextField: View {
    
    var sectionText: String
    var notValidInput: String

    
    @Binding var textFieldValue: String

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(sectionText)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                
            
            TextField("", text: $textFieldValue)
                
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 10)
             .background(.gray)
            
            
            
            Text(notValidInput)
                .font(.system(size: 15))
                .foregroundColor(.red)
                

            
            
                
        }
    }
}

