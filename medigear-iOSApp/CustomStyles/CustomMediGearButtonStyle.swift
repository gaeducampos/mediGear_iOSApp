//
//  CustomButton.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 15/3/23.
//

import SwiftUI

struct MediGearButtonStyle: ButtonStyle {
    private let enableColor = Color(red: 0.518, green: 0.812, blue: 0)
    private let disableColor = Color(red: 0.827, green: 0.827, blue: 0.827)
    var isEnable: Bool
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .background(isEnable ? enableColor : disableColor)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}


