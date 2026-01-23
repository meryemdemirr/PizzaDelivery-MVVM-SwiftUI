//
//  HomeView.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var cartManager = CartManager()
    @State private var selectedCategory: Category = .all
    @State private var searchText: String = ""
    @State private var navigationPath = NavigationPath()
    @State private var currentDate = Date() // Tarih değişikliği için state
    
    private let sampleData = SampleData.shared
    @State private var filteredProducts: [Product] = []
    
    // Tarih değişikliğini kontrol etmek için timer
    private let dateCheckTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        headerView
                        
                        // Extra Discount Section
                        discountBannerView
                        
                        // Categories Section
                        categoriesSection
                        
                        // Popular Food Section
                        popularFoodSection
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
                
                // Toast Overlay
                ToastView(message: cartManager.toastMessage, isShowing: $cartManager.showToast)
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .discountProducts:
                    DiscountProductsView(cartManager: cartManager)
                case .cart:
                    CartView(cartManager: cartManager)
                }
            }
            .onAppear {
                updateFilteredProducts()
                currentDate = Date() // Uygulama açıldığında tarihi güncelle
            }
            .onReceive(dateCheckTimer) { _ in
                // Her dakika tarih kontrolü yap
                let newDate = Date()
                let calendar = Calendar.current
                if !calendar.isDate(currentDate, inSameDayAs: newDate) {
                    currentDate = newDate
                    updateFilteredProducts()
                }
            }
            .onChange(of: selectedCategory) { _ in
                updateFilteredProducts()
            }
            .onChange(of: searchText) { _ in
                updateFilteredProducts()
            }
        }
        .environmentObject(cartManager)
    }
    
    enum NavigationDestination: Hashable {
        case discountProducts
        case cart
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            // User Profile
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.orange)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Meryem Demir")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Good morning!")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Cart Button
            Button(action: {
                navigationPath.append(NavigationDestination.cart)
            }) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.orange)
                    
                    if cartManager.items.count > 0 {
                        Text("\(cartManager.items.count)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 8, y: -8)
                    }
                }
            }
        }
        .padding(.top, 8)
    }
    
    // MARK: - Discount Banner View
    private var discountBannerView: some View {
        Button(action: {
            navigationPath.append(NavigationDestination.discountProducts)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color.orange.opacity(0.8), Color.orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 180)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("%50'ye Varan")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("İndirimler")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Tüm indirimli ürünler için tıklayın")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    // Pizza görseli
                    Image(systemName: "pizza.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))
                }
                .padding(24)
            }
        }
    }
    
    // MARK: - Categories Section
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Categories")
                .font(.system(size: 20, weight: .bold))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryChip(
                            category: category,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = category
                            if category != .all {
                                searchText = ""
                            }
                        }
                    }
                }
            }
            
            // Search Bar (only for "All" category)
            if selectedCategory == .all {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search products...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Popular Food Section
    private var popularFoodSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(selectedCategory == .all ? "Popular Food" : selectedCategory.rawValue)
                .font(.system(size: 20, weight: .bold))
            
            let productsToShow = getProductsToShow()
            
            if productsToShow.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No products found")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 16) {
                    ForEach(productsToShow) { product in
                        NavigationLink(destination: ProductDetailView(product: product, cartManager: cartManager)) {
                            ProductCard(product: product) {
                                cartManager.addToCart(product)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func getProductsToShow() -> [Product] {
        if selectedCategory == .all {
            if searchText.isEmpty {
                return sampleData.popularProducts
            } else {
                return filteredProducts
            }
        } else {
            return filteredProducts
        }
    }
    
    private func updateFilteredProducts() {
        if selectedCategory == .all {
            if searchText.isEmpty {
                filteredProducts = []
            } else {
                filteredProducts = sampleData.searchProducts(query: searchText)
            }
        } else {
            filteredProducts = sampleData.products(for: selectedCategory)
        }
    }
}

#Preview {
    HomeView()
}
