//
//  ProductCard.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 120)
                
                // Ürün görseli tam ortada
                ProductImageView(imageName: product.imageName, width: 80, height: 80)
                
                // İndirim Etiketi (sadece aktif indirim varsa) - Sağ üst köşede
                if product.isDiscountActive, let discount = product.discountPercentage {
                    VStack {
                        HStack {
                            Spacer()
                            Text("%\(discount) OFF")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    LinearGradient(
                                        colors: [Color.red, Color.red.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(8)
                                .shadow(color: Color.red.opacity(0.3), radius: 3, x: 0, y: 2)
                        }
                        Spacer()
                    }
                    .padding(8)
                }
            }
            
            // Product Name
            Text(product.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 36)
            
            // Price and Add Button
            HStack {
                // Price
                VStack(alignment: .leading, spacing: 4) {
                    if product.isDiscountActive {
                        // İndirimli fiyat (büyük, belirgin, turuncu)
                        Text("\(String(format: "%.2f", product.discountedPrice)) TL")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.orange)
                        
                        // Orijinal fiyat (üstü çizili, gri, küçük)
                        Text("\(String(format: "%.2f", product.originalPrice)) TL")
                            .font(.system(size: 11))
                            .foregroundColor(.gray.opacity(0.7))
                            .strikethrough()
                    } else {
                        // Normal fiyat
                        Text("\(String(format: "%.2f", product.originalPrice)) TL")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
                
                // Add to Cart Button
                Button(action: onAddToCart) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 4)
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ProductCard(
        product: Product(
            name: "Margherita Pizza",
            description: "Classic Italian pizza",
            price: 89.99,
            imageName: "pizza.fill",
            category: .pizza,
            isDiscounted: true,
            discountPercentage: 50
        ),
        onAddToCart: {}
    )
    .padding()
}
