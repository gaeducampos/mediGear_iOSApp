//
//  SearchBar.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 28/3/23.
//

import SwiftUI
import NukeUI

struct HomeView: View {
    @ObservedObject var viewModel: MedicalMinistrationViewModel
    
    init(viewModel: MedicalMinistrationViewModel) {
        self.viewModel = viewModel
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Nuestros Proveedores")
                    ScrollView(.horizontal) {
                        HStack(spacing: 60) {
                            ForEach(viewModel.medicalManufacturers) {item in
                                MedicalMinistrationStack(
                                    name: nil,
                                    image: item.attributes.img)
                                .frame(maxWidth: 350, maxHeight: 200)
                            }
                        }
                    }
                }
                
                VStack {
                    VStack {
                        ForEach(viewModel.medicalSpecialties) { item in
                            VStack(alignment: .leading) {
                                Text(item.attributes.name)
                                    .font(.system(size: 20))
                                    .font(Font.headline.weight(.heavy))
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 60) {
                                        ForEach(item.attributes.subCategories) { category in
                                            MedicalMinistrationStack(
                                                name: category.attributes.name,
                                                image: category.attributes.img)
                                            .frame(maxWidth: 350, maxHeight: 200)
                                        }
                                    }
                                }
                            }
                            .padding(.top)
                        }
                    }
                 //   }
                }
            }
        }
        .padding(.leading)
        
    }
}




struct MedicalMinistrationStack: View {
    let name: String?
    let image: String
    var body: some View {
        VStack {
            LazyImage(url: URL(string: "\(NetworkProvider.Constants.baseLocalHost)\(image)")) {state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                }
            }
            .cornerRadius(20)
            .frame(maxWidth: 150, maxHeight: 100)
            
            VStack {
                if let imageName = name {
                    Text(imageName)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14))
                        .scrollContentBackground(.hidden)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(service: .init(netWorkProvider: .init())))
    }
}
