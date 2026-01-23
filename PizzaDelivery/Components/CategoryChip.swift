//
//  CategoryChip.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct CategoryChip: View {
    let category: Category
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(category.rawValue)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.orange : Color.gray.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

#Preview {
    HStack {
        CategoryChip(category: .all, isSelected: true, onTap: {})
        CategoryChip(category: .pizza, isSelected: false, onTap: {})
    }
    .padding()
}
