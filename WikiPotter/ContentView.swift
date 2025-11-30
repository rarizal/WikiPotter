//
//  ContentView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
                TabView {
                    Tab ("Books", systemImage: "circle.fill") {
                        BookView()
                    }
                    
                    Tab ("Characters", systemImage: "triangle.fill") {
                        Text("Characters here")
                    }
                    
                    Tab ("Movies", systemImage: "square.fill") {
                        Text("Movies here")
                    }
                    
                    Tab ("Potions", systemImage: "pentagon.fill") {
                        Text("Potions here")
                    }
                    
                    Tab ("Spells", systemImage: "hexagon.fill") {
                        Text("Heart")
                    }
                }
                .tabBarMinimizeBehavior(.onScrollDown)
    }

}

#Preview {
    ContentView()
}
