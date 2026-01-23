//
//  Product.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let imageName: String
    let category: Category
    let rating: Double
    let ingredients: String
    let isDiscounted: Bool
    let discountPercentage: Int?
    let discountStartDate: Date?
    let discountEndDate: Date?
    
    init(id: UUID = UUID(), name: String, description: String, price: Double, imageName: String, category: Category, rating: Double = 4.0, ingredients: String = "", isDiscounted: Bool = false, discountPercentage: Int? = nil, discountStartDate: Date? = nil, discountEndDate: Date? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageName = imageName
        self.category = category
        self.rating = rating
        self.ingredients = ingredients
        self.isDiscounted = isDiscounted
        self.discountPercentage = discountPercentage
        self.discountStartDate = discountStartDate
        self.discountEndDate = discountEndDate
    }
    
    // İndirimin şu an aktif olup olmadığını kontrol eder
    var isDiscountActive: Bool {
        guard isDiscounted,
              let startDate = discountStartDate,
              let endDate = discountEndDate else {
            return false
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        let start = Calendar.current.startOfDay(for: startDate)
        let end = Calendar.current.startOfDay(for: endDate)
        
        return today >= start && today <= end
    }
    
    // Aktif indirimli fiyat (tarih kontrolü ile)
    var discountedPrice: Double {
        if isDiscountActive, let discount = discountPercentage {
            return price * (1 - Double(discount) / 100)
        }
        return price
    }
    
    // Orijinal fiyat (her zaman)
    var originalPrice: Double {
        return price
    }
}

enum Category: String, CaseIterable, Codable {
    case all = "All"
    case pizza = "Pizza"
    case burger = "Burger"
    case pasta = "Pasta"
    case dessert = "Dessert"
    case drink = "Drink"
}
