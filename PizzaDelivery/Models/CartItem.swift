//
//  CartItem.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import Foundation

struct CartItem: Identifiable {
    let id: UUID
    let product: Product
    var quantity: Int
    
    init(id: UUID = UUID(), product: Product, quantity: Int = 1) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
    
    // Orijinal fiyat toplamı (indirimsiz)
    var originalTotalPrice: Double {
        product.price * Double(quantity)
    }
    
    // İndirimli fiyat toplamı
    var discountedTotalPrice: Double {
        product.discountedPrice * Double(quantity)
    }
    
    // Bu ürün için toplam indirim tutarı
    // ÖNEMLİ: Ödeme anındaki tarihe göre kontrol edilir (isDiscountActive)
    var itemDiscount: Double {
        if product.isDiscountActive {
            return (product.originalPrice - product.discountedPrice) * Double(quantity)
        }
        return 0
    }
    
    // Ödenecek tutar (indirimli fiyat)
    var totalPrice: Double {
        discountedTotalPrice
    }
}
