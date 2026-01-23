//
//  ToastView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            if isShowing {
                Text(message)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.bottom, 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isShowing)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.2)
        ToastView(message: "Added to cart!", isShowing: .constant(true))
    }
}
