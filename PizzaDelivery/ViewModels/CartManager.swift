//
//  CartManager.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import Foundation
import SwiftUI

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    
    // Subtotal: Tüm ürünlerin orijinal fiyatlarının toplamı (indirimsiz)
    var subtotal: Double {
        items.reduce(0) { $0 + $1.originalTotalPrice }
    }
    
    // Discount: İndirimli ürünler için toplam indirim tutarı
    // Her indirimli ürün için: (Orijinal Fiyat - İndirimli Fiyat) × Adet
    // ÖNEMLİ: Ödeme anındaki tarihe göre kontrol edilir
    var discount: Double {
        items.reduce(0) { total, item in
            // Ödeme anındaki tarihe göre indirim kontrolü
            if item.product.isDiscountActive {
                return total + item.itemDiscount
            }
            return total
        }
    }
    
    // Total: Ödenecek toplam tutar (subtotal - discount)
    var total: Double {
        subtotal - discount
    }
    
    func addToCart(_ product: Product, quantity: Int = 1) {
        if let existingIndex = items.firstIndex(where: { $0.product.id == product.id }) {
            items[existingIndex].quantity += quantity
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
        showToast(message: "Added to cart!")
    }
    
    func removeFromCart(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if quantity > 0 {
                items[index].quantity = quantity
            } else {
                items.remove(at: index)
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func showToast(message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    func processPayment() {
        showToast(message: "Payment successful!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.clearCart()
        }
    }
}
