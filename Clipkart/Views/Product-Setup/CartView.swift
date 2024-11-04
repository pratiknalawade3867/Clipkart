//
//  CartView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 31/10/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var emptycart: Bool = false

    var body: some View {
        List {
            ForEach(cartManager.cartItems, id: \.id) { product in
                NavigationLink(destination: ProductDetailsView(products: cartManager.cartItems, index: 0)) {
                    ProductRowView(product: product)
                }
            }
//            if cartManager.cartItems.isEmpty {
//                emptycart = true
//            }
        }
        .listStyle(.plain)
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $emptycart) {
            Alert(title: Text(ViewStrings.alertTxt.getText()), message: Text("Your cart is empty"), dismissButton: .default(Text(ViewStrings.okTxt.getText())))
        }
    }
}



class CartManager: ObservableObject {
    @Published var cartItems: [Product] = []
    
    func addToCart(product: Product) {
        cartItems.append(product)
    }
}

