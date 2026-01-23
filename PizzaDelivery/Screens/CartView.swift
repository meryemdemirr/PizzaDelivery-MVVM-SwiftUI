//
//  CartView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss
    @State private var currentDate = Date() // Tarih değişikliği için state
    
    // Tarih değişikliğini kontrol etmek için timer
    private let dateCheckTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if cartManager.items.isEmpty {
                // Empty Cart View
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 80))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Your cart is empty")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Text("Add some delicious food!")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            } else {
                VStack(spacing: 0) {
                    // Cart Items List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(cartManager.items) { item in
                                CartItemRow(item: item, cartManager: cartManager)
                            }
                        }
                        .padding()
                        .padding(.bottom, 200)
                    }
                    
                    Spacer()
                    
                    // Order Summary & Payment
                    VStack(spacing: 16) {
                        Divider()
                        
                        // Order Summary
                        VStack(spacing: 12) {
                            HStack {
                                Text("Subtotal")
                                    .font(.system(size: 16))
                                Spacer()
                                Text("\(String(format: "%.2f", cartManager.subtotal)) TL")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            
                            HStack {
                                Text("Discount")
                                    .font(.system(size: 16))
                                Spacer()
                                if cartManager.discount > 0 {
                                    Text("-\(String(format: "%.2f", cartManager.discount)) TL")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.green)
                                } else {
                                    Text("0.00 TL")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 20, weight: .bold))
                                Spacer()
                                Text("\(String(format: "%.2f", cartManager.total)) TL")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        // Pay Now Button
                        Button(action: {
                            cartManager.processPayment()
                        }) {
                            Text("Pay Now")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.orange)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 34)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                }
            }
            
            // Toast
            ToastView(message: cartManager.toastMessage, isShowing: $cartManager.showToast)
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            currentDate = Date() // Ekran açıldığında tarihi güncelle
        }
        .onReceive(dateCheckTimer) { _ in
            // Her dakika tarih kontrolü yap (sepet fiyatlarını güncellemek için)
            let newDate = Date()
            let calendar = Calendar.current
            if !calendar.isDate(currentDate, inSameDayAs: newDate) {
                currentDate = newDate
                // Tarih değiştiğinde sepet otomatik güncellenecek (isDiscountActive kontrolü sayesinde)
            }
        }
    }
}

// MARK: - Cart Item Row
struct CartItemRow: View {
    let item: CartItem
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        HStack(spacing: 16) {
            // Product Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 80, height: 80)
                
                ProductImageView(imageName: item.product.imageName, width: 50, height: 50)
                    .cornerRadius(8)
            }
            
            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                Text(item.product.name)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                
                Text("Quantity: \(item.quantity)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                // Fiyat gösterimi - indirimli ürünlerde hem orijinal hem indirimli fiyat
                // ÖNEMLİ: Ödeme anındaki tarihe göre kontrol edilir
                if item.product.isDiscountActive {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(String(format: "%.2f", item.totalPrice)) TL")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.orange)
                        
                        Text("\(String(format: "%.2f", item.originalTotalPrice)) TL")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .strikethrough()
                    }
                } else {
                    Text("\(String(format: "%.2f", item.totalPrice)) TL")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.orange)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    cartManager.removeFromCart(item)
                }
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
            .tint(.red)
        }
    }
}

#Preview {
    NavigationStack {
        CartView(cartManager: CartManager())
    }
}
