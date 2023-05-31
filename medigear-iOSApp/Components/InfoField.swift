//
//  InfoField.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 14/5/23.
//

import SwiftUI

struct InfoField: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text(value)
            }
            .padding()
            Spacer()
        }
    }
}

struct InfoField_Previews: PreviewProvider {
    static var previews: some View {
        InfoField(title: "Nombre(s)", value: "Gabriel")
    }
}
