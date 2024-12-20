//
//  MenuTabView.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI
import Factory

struct MainTabView: View {
    @StateObject private var catViewModel = Container.shared.catViewModel()
    @StateObject private var dogViewModel = Container.shared.dogViewModel()
    
    var body: some View {
        TabView {
            // Cats Tab
            CatView(viewModel: catViewModel)
                .tabItem {
                    Label("Cats", systemImage: "pawprint.fill")
                }
            
            // Dogs Tab
            DogView(viewModel: dogViewModel)
                .tabItem {
                    Label("Dogs", systemImage: "dog.fill")
                }
        }
    }
}
