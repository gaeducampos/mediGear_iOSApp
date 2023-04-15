//
//  SearchResultView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 10/4/23.
//

import SwiftUI
import NukeUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchBarViewModel
    let singleProductViewModel: SingleProductViewModel
    
    init(viewModel: SearchBarViewModel, singleProductViewModel: SingleProductViewModel) {
        self.viewModel = viewModel
        self.singleProductViewModel = singleProductViewModel
    }
    
    
    var body: some View {
        VStack {
            List(viewModel.products) { product in
                HStack {
                    LazyImage(url: URL(string: "\(NetworkProvider.Constants.baseLocalHost)\(product.attributes.img)")) { state in
                        if let image = state.image {
                            image.resizable().aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(maxWidth: 50, maxHeight: 50)
                    Text(product.attributes.name)
                }
                .onTapGesture {
                    singleProductViewModel.productHomeSubject.send(product)
                    singleProductViewModel.dismissSearchController.send(false)
                }
            }
        }
    }
}

//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView(viewModel: .init(service: .init(netWorkProvider: .init())))
//    }
//}
