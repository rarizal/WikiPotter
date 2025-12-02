//
//  CharacterView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 24/11/25.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    @StateObject private var viewModel = CharacterViewModel()


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    if viewModel.isLoading {
                        ProgressView("Loading Characters...")
                            .padding(.top, 50)
                    } else if let error = viewModel.errorMessage {
                        // Error States
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text(error)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 50)
                    } else {
                        // All Characters
//                        CharacterAll(characters: viewModel.isAccending ? viewModel.characters : viewModel.characters.reversed())
                        CharacterAll(characters: viewModel.characters)
                    }
                }
            }
            .navigationTitle(Text("Characters"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    
                    Menu{
                        Button("Accending", systemImage: viewModel.isAccending ? "checkmark" : ""){
                            Task {
                                
                                await viewModel.sortToggle() }
                        }.disabled(viewModel.isAccending)
                        
                        Button("Descending", systemImage: viewModel.isAccending ? "": "checkmark"){
                            Task {
                                await viewModel.sortToggle() }
                        }.disabled(!viewModel.isAccending)
                        
                    } label: {
                        Label("More", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
    
    
}


struct CharacterAll: View {
    let characters: [CharacterDataWrapper]
    @StateObject private var viewModel = CharacterViewModel()
    
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
                Text("All Characters")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        print(viewModel.isAccending)
                    }
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(characters) { character in
                    NavigationLink(destination: DetailsView(item: character)) {
                        VStack(spacing: 10) {
                            Group {
                                if let imageString = character.attributes.image,
                                   let url = URL(string: imageString) {
                                    KFImage(url)
                                        .resizable()
                                } else {
                                    Image("noAvatar")
                                        .resizable()
                                }
                            }
                            .scaledToFill()
                            .frame(width: itemWidth, height: itemWidth)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(character.attributes.name ?? "No Name")
                                    .font(.title3)
                                    .lineLimit(1)
                                    .fontWeight(.medium)
                                
                                Text(character.attributes.house ?? "No House")
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

#Preview {
    CharacterView()
}

