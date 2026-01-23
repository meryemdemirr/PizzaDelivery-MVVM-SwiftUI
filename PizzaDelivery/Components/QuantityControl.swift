//
//  QuantityControl.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct QuantityControl: View {
    @Binding var quantity: Int
    let minQuantity: Int = 1
    let maxQuantity: Int = 10
    let onLimitReached: (String) -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            // Decrease Button
            Button(action: {
                if quantity > minQuantity {
                    quantity -= 1
                } else {
                    onLimitReached("Minimum quantity is \(minQuantity)")
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(quantity > minQuantity ? .orange : .gray)
            }
            .disabled(quantity <= minQuantity)
            
            // Quantity Display
            Text("\(quantity)")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
                .frame(minWidth: 40)
            
            // Increase Button
            Button(action: {
                if quantity < maxQuantity {
                    quantity += 1
                } else {
                    onLimitReached("Maximum quantity is \(maxQuantity)")
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(quantity < maxQuantity ? .orange : .gray)
            }
            .disabled(quantity >= maxQuantity)
        }
    }
}

#Preview {
    QuantityControl(quantity: .constant(1), onLimitReached: { message in
        print(message)
    })
    .padding()
}
