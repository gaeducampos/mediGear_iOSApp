//
//  SecureCustomTexField.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 21/3/23.
//

import SwiftUI
import TogglableSecureField

struct SecureCustomTexField: View {
    var sectionText: String
    var notValidInput: String
    
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading,  spacing: 0) {
            Text(sectionText)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                
            
            
            TogglableSecureField("",
                                 secureContent: $password,
                                 onCommit: {
                guard !password.isEmpty else { return }
            })
            
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

