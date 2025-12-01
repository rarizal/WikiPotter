//
//  Potion.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 24/11/25.
//

import SwiftUI
import Kingfisher

struct SpellView: View {
    @StateObject private var viewModel = SpellViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    if viewModel.isLoading {
                        ProgressView("Loading Spells...")
                            .padding(.top, 50)
                    } else if let error = viewModel.errorMessage {
                        // Error State
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text(error)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 50)
                    } else {
                        // All Spells
                        SpellAll(spells: viewModel.spells)
                    }
                }
            }
            .navigationTitle(Text("Spells"))
          
        }
        .task {
            await viewModel.loadSpells()
        }
    }
    
    
}


struct SpellAll: View {
    let spells: [SpellDataWrapper]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var itemWidth: CGFloat {
        (UIScreen.main.bounds.width - 60) / 2
    }
    
    var body: some View {
        
        VStack(spacing: 15) {
            // Title
            HStack {
                Text("All Spells")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(spells) { spell in
                    NavigationLink(destination: DetailsView(item: spell)) {
                        VStack(spacing: 10) {
                            Group {
                                if let imageString = spell.attributes.image,
                                   let url = URL(string: imageString) {
                                    KFImage(url)
                                        .resizable()
                                } else {
              
                                    Image("noSpell")
                                        .resizable()
                                }
                            }
                            .scaledToFill()
                            .frame(width: itemWidth, height: itemWidth)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(spell.attributes.name)
                                    .font(.title3)
                                    .lineLimit(1)
                                    .fontWeight(.medium)
                                
                                Text(spell.attributes.category ?? "Unknown")
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: itemWidth)
                    }.buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    SpellView()
//}
