//
//  HomeScreenView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
                TabView {
                    Tab ("Books", systemImage: "circle.fill") {
                        BookView()
                    }
                    
                    Tab ("Characters", systemImage: "triangle.fill") {
                        CharacterView()
                    }
                    
                    Tab ("Movies", systemImage: "square.fill") {
                        MovieView()
                    }
                    
                    Tab ("Potions", systemImage: "pentagon.fill") {
                        PotionView()
                    }
                    
                    Tab ("Spells", systemImage: "hexagon.fill") {
                        SpellView()
                    }
                }
                .tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    HomeScreenView()
}
