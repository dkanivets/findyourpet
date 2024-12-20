//
//  MenuTabView.swift
//  Find Your Pet
//
//  Created by Dmitry Kanivets on 20.12.2024.
//

import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray6
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            CatView()
                .tabItem {
                    Label("Cats", systemImage: "pawprint.fill")
                }

            DogView()
                .tabItem {
                    Label("Dogs", systemImage: "dog.fill")
                }
        }
        .accentColor(.blue)
    }
}
