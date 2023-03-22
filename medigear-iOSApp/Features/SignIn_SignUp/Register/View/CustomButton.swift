//
//  CustomButton.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI

struct CustomMediGearButtonStyle: View {
    var text: String
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
        }
        .background(Color(red: 0.518, green: 0.812, blue: 0))
        .cornerRadius(10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomMediGearButtonStyle(text: "Inicia Sesisión", action: {} )
    }
    
}

