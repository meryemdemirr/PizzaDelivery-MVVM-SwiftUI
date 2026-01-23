//
//  ProductDetailView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var cartManager: CartManager
    @State private var quantity: Int = 1
    @State private var showLimitAlert: Bool = false
    @State private var limitMessage: String = ""
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Product Image
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                        
                        ProductImageView(imageName: product.imageName, width: 300, height: 300)
                            .clipped()
                    }
                    
                    VStack(spacing: 16) {
                        // Product Name
                        Text(product.name)
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        // Rating
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", product.rating))
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                        // Price
                        HStack {
                            if product.isDiscountActive {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(String(format: "%.2f", product.discountedPrice)) TL")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.orange)
                                    
                                    Text("\(String(format: "%.2f", product.originalPrice)) TL")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                }
                            } else {
                                Text("\(String(format: "%.2f", product.originalPrice)) TL")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.orange)
                            }
                            
                            Spacer()
                            
                            // Quantity Control
                            QuantityControl(quantity: $quantity) { message in
                                limitMessage = message
                                showLimitAlert = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showLimitAlert = false
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Description")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(product.description)
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                            
                            if !product.ingredients.isEmpty {
                                Text("Ingredients")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.top, 8)
                                
                                Text(product.ingredients)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 100)
                }
            }
            
            // Add to Cart Button (Fixed at bottom)
            VStack {
                Spacer()
                
                Button(action: {
                    cartManager.addToCart(product, quantity: quantity)
                }) {
                    Text("Add to Cart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 34)
                .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
            // Toast
            ToastView(message: cartManager.toastMessage, isShowing: $cartManager.showToast)
            
            // Limit Alert
            if showLimitAlert {
                VStack {
                    Text(limitMessage)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.top, 100)
                    
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.spring(response: 0.3), value: showLimitAlert)
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(
            product: SampleData.shared.products[0],
            cartManager: CartManager()
        )
    }
}
