//
//  ProductDetailsView.swift
//  Clipkart
//
//  Created by pratik.nalawade on 25/10/24.
//

import SwiftUI

struct ProductDetailsView: View {
    
    var products: [Product] = []
    @State var index: Int
    @EnvironmentObject var cartManager: CartManager
    @State private var cartAdded: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                
                Button(action: {
                    index -= 1
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .bold()
                })
                .opacity(index == 0 ? 0 : 1)
                
                .multilineTextAlignment(.trailing)
                
                Spacer()
                Button(action: {
                    cartManager.addToCart(product: products[index])
                    cartAdded = true
                }, label: {
                    Image(systemName: "heart.circle.fill")
                        .foregroundColor(.gray)
                        .bold()
                })
                Spacer()
                
                Button(action: {
                    withAnimation {
                        index += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .bold()
                })
                .opacity(index == products.count - 1 ? 0 : 1)
                .multilineTextAlignment(.trailing)
                
            }
            
            Text(products[index].title)
                .font(.headline)
                .padding(.top)
            
            Text(products[index].description)
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            RatingInfoView(rating: products[index].rating.rate.toString())
            
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Price")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(products[index].price.currencyFormat())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.indigo)
                }
                .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Image(systemName: "cart.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .frame(width: 50, height: 50)
                        .background(.indigo)
                    
                    Text("Buy Now")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 50)
                        .background(Color(UIColor.darkGray))
                }
                .cornerRadius(15)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.trailing)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(.gray.opacity(0.2))
            .clipShape(.buttonBorder)
        }
        .padding()
        .background(
            // Conditional NavigationLink
            NavigationLink(destination: CartView().environmentObject(cartManager), isActive: $cartAdded) {
                EmptyView()
            }
                .hidden() // Hide the navigation link
        )
    }
    
}

#Preview {
    ProductDetailsView(products: [Product(id: 0, title: "", description: "", category: "", image: "", price: 0.0, rating: Rate(rate: 0.0, count: 0))], index: 0)
}

struct RatingInfoView: View {
    
    let rating: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
                Text(rating + " " + "Ratings")
                    .foregroundStyle(.secondary)
            }
            .font(.callout)
            
            Spacer()
            
            circleImage
            
            Spacer()
            
            Text("4.6k Reviews")
            
            Spacer()
            
            circleImage
            
            Spacer()
            
            Text("4.6k Sold")
            
        }
        .foregroundStyle(.secondary)
        .font(.callout)
    }
    
    var circleImage: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 8, height: 8)
    }
}
