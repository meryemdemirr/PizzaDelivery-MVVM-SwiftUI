//
//  SampleData.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import Foundation

class SampleData {
    static let shared = SampleData()
    
    // İndirim tarihleri: 14 Ocak 2026'da başlayıp 14 Ocak 2026'da bitiyor (tek günlük kampanya)
    private let discountStartDate = DateHelper.createDate(year: 2026, month: 1, day: 14) ?? Date()
    private let discountEndDate = DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59) ?? Date()
    
    let products: [Product] = [
        // Pizza (Ana Yemekler: 200-300 TL)
        Product(
            name: "Margherita Pizza",
            description: "Classic Italian pizza with fresh mozzarella, tomato sauce, and basil",
            price: 250.00,
            imageName: "pizza.margherita",
            category: .pizza,
            rating: 4.5,
            ingredients: "Mozzarella, Tomato Sauce, Basil, Olive Oil",
            isDiscounted: true,
            discountPercentage: 50,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        Product(
            name: "Pepperoni Pizza",
            description: "Spicy pepperoni with mozzarella and tomato sauce",
            price: 280.00,
            imageName: "pizza.pepperoni",
            category: .pizza,
            rating: 4.7,
            ingredients: "Pepperoni, Mozzarella, Tomato Sauce",
            isDiscounted: false
        ),
        Product(
            name: "BBQ Chicken Pizza",
            description: "Grilled chicken with BBQ sauce, red onions, and mozzarella",
            price: 300.00,
            imageName: "pizza.bbq",
            category: .pizza,
            rating: 4.6,
            ingredients: "Chicken, BBQ Sauce, Red Onions, Mozzarella",
            isDiscounted: true,
            discountPercentage: 40,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        Product(
            name: "Vegetarian Pizza",
            description: "Fresh vegetables with mozzarella and tomato sauce",
            price: 240.00,
            imageName: "pizza.vegetarian",
            category: .pizza,
            rating: 4.3,
            ingredients: "Bell Peppers, Mushrooms, Olives, Mozzarella",
            isDiscounted: true,
            discountPercentage: 35,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        
        // Burger (Ana Yemekler: 200-300 TL)
        Product(
            name: "Classic Burger",
            description: "Juicy beef patty with lettuce, tomato, and special sauce",
            price: 220.00,
            imageName: "burger.classic",
            category: .burger,
            rating: 4.4,
            ingredients: "Beef Patty, Lettuce, Tomato, Special Sauce, Bun"
        ),
        Product(
            name: "Cheese Burger",
            description: "Classic burger with melted cheese",
            price: 240.00,
            imageName: "burger.cheese",
            category: .burger,
            rating: 4.5,
            ingredients: "Beef Patty, Cheese, Lettuce, Tomato, Bun",
            isDiscounted: true,
            discountPercentage: 30,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        Product(
            name: "Chicken Burger",
            description: "Grilled chicken breast with fresh vegetables",
            price: 210.00,
            imageName: "burger.chicken",
            category: .burger,
            rating: 4.2,
            ingredients: "Chicken Breast, Lettuce, Tomato, Mayo, Bun",
            isDiscounted: true,
            discountPercentage: 25,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        
        // Pasta (Ana Yemekler: 200-300 TL)
        Product(
            name: "Spaghetti Carbonara",
            description: "Creamy pasta with bacon and parmesan cheese",
            price: 200.00,
            imageName: "pasta.carbonara",
            category: .pasta,
            rating: 4.6,
            ingredients: "Spaghetti, Bacon, Eggs, Parmesan, Cream",
            isDiscounted: true,
            discountPercentage: 30,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        Product(
            name: "Fettuccine Alfredo",
            description: "Rich and creamy fettuccine with parmesan sauce",
            price: 190.00,
            imageName: "pasta.alfredo",
            category: .pasta,
            rating: 4.4,
            ingredients: "Fettuccine, Cream, Parmesan, Butter"
        ),
        
        // Dessert (Tatlılar: 150-250 TL)
        Product(
            name: "Chocolate Cake",
            description: "Rich chocolate cake with cream frosting",
            price: 180.00,
            imageName: "dessert.cake",
            category: .dessert,
            rating: 4.8,
            ingredients: "Chocolate, Flour, Sugar, Cream, Eggs",
            isDiscounted: true,
            discountPercentage: 20,
            discountStartDate: DateHelper.createDate(year: 2026, month: 1, day: 14),
            discountEndDate: DateHelper.createDate(year: 2026, month: 1, day: 14, hour: 23, minute: 59)
        ),
        Product(
            name: "Tiramisu",
            description: "Classic Italian dessert with coffee and mascarpone",
            price: 200.00,
            imageName: "dessert.tiramisu",
            category: .dessert,
            rating: 4.7,
            ingredients: "Mascarpone, Coffee, Cocoa, Ladyfingers"
        ),
        Product(
            name: "Ice Cream Sundae",
            description: "Vanilla ice cream with chocolate sauce and toppings",
            price: 150.00,
            imageName: "dessert.icecream",
            category: .dessert,
            rating: 4.5,
            ingredients: "Vanilla Ice Cream, Chocolate Sauce, Nuts, Cherry"
        )
    ]
    
    // Aktif indirimli ürünler (tarih kontrolü ile)
    var discountedProducts: [Product] {
        products.filter { $0.isDiscountActive }
    }
    
    // Tüm indirimli ürünler (tarih kontrolü olmadan)
    var allDiscountedProducts: [Product] {
        products.filter { $0.isDiscounted }
    }
    
    var popularProducts: [Product] {
        products.sorted { $0.rating > $1.rating }.prefix(6).map { $0 }
    }
    
    func products(for category: Category) -> [Product] {
        if category == .all {
            return products
        }
        return products.filter { $0.category == category }
    }
    
    func searchProducts(query: String) -> [Product] {
        if query.isEmpty {
            return products
        }
        return products.filter { product in
            product.name.localizedCaseInsensitiveContains(query) ||
            product.description.localizedCaseInsensitiveContains(query)
        }
    }
}
