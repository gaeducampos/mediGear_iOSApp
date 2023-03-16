//
//  CustomButton.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI

struct MediGearButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .background(Color(red: 0.518, green: 0.812, blue: 0))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}


