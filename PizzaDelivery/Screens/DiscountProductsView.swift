//
//  DiscountProductsView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct DiscountProductsView: View {
    @ObservedObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    
    // Aktif indirimli ürünler (tarih kontrolü ile)
    private var discountedProducts: [Product] {
        SampleData.shared.discountedProducts
    }
    
    var body: some View {
        ZStack {
            if discountedProducts.isEmpty {
                // Boş durum
                VStack(spacing: 20) {
                    Image(systemName: "tag.slash")
                        .font(.system(size: 80))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Şu anda aktif indirim bulunmuyor")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Text("Yakında yeni indirimler olacak!")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("İndirimli Ürünler")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.horizontal)
                            .padding(.top)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 16) {
                            ForEach(discountedProducts) { product in
                                NavigationLink(destination: ProductDetailView(product: product, cartManager: cartManager)) {
                                    ProductCard(product: product) {
                                        cartManager.addToCart(product)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 100)
                }
            }
            
            ToastView(message: cartManager.toastMessage, isShowing: $cartManager.showToast)
        }
        .navigationTitle("İndirimler")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DiscountProductsView(cartManager: CartManager())
    }
}
