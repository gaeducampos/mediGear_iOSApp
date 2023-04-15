//
//  ProductView.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 12/4/23.
//

import SwiftUI
import NukeUI
import Combine

struct ProductListView: View {
    var products: [Product]
    let singleProductViewModel: SingleProductViewModel

    init(products: [Product], singleProductViewModel: SingleProductViewModel) {
        self.products = products
        self.singleProductViewModel = singleProductViewModel
    }

    var body: some View {
        VStack {
            List(products) { product in
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
                }
            }
        }
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView(products: [Product(id: <#T##Int#>, attributes: <#T##ProductAttributes#>)])
//    }
//}
