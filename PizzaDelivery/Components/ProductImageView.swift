//
//  ProductImageView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI
import UIKit

struct ProductImageView: View {
    let imageName: String
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var contentMode: ContentMode = .fit
    
    // Map product image names to asset names
    private var assetName: String {
        // Convert imageName to asset name format
        // e.g., "pizza.margherita" -> "Margherita Pizza"
        let mapping: [String: String] = [
            "pizza.margherita": "Margherita Pizza",
            "pizza.pepperoni": "Pepperoni Pizza",
            "pizza.bbq": "BBQ Chicken Pizza",
            "pizza.vegetarian": "Vegetarian Pizza",
            "burger.classic": "Classic Burger",
            "burger.cheese": "Cheese Burger",
            "burger.chicken": "Chicken Burger",
            "pasta.carbonara": "Spaghetti Carbonara",
            "pasta.alfredo": "Fettuccine Alfredo",
            "dessert.cake": "Chocolate Cake",
            "dessert.tiramisu": "Tiramisu",
            "dessert.icecream": "Ice Cream Sundae"
        ]
        
        return mapping[imageName] ?? imageName
    }
    
    @ViewBuilder
    var body: some View {
        if let width = width, let height = height {
            // Try to load from assets, fallback to placeholder if not found
            if UIImage(named: assetName) != nil {
                Image(assetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .contentShape(Rectangle())
            } else {
                // Fallback placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: width, height: height)
                    
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.5, height: height * 0.5)
                        .foregroundColor(.orange.opacity(0.5))
                }
            }
        } else {
            if UIImage(named: assetName) != nil {
                Image(assetName)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.orange.opacity(0.5))
            }
        }
    }
}

#Preview {
    ProductImageView(imageName: "pizza.margherita", width: 100, height: 100)
        .padding()
}
