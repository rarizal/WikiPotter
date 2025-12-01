//
//  MovieView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import SwiftUI
import Kingfisher

struct MovieView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    if viewModel.isLoading {
                        ProgressView("Loading Movies...")
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
                        // Recommendation
                        MovieRecommendationView(movies: viewModel.movies)
                        // All Movie
                        MovieAll(movies: viewModel.movies)
                    }
                }
            }
            .navigationTitle(Text("Movies"))
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}

struct MovieRecommendationView: View {
    let movies: [MovieDataWrapper]
    
    private var itemWidth: CGFloat {
        UIScreen.main.bounds.width - 60
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("For You")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            // Scrollable item
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(movies.shuffled().prefix(4)) { movie in
                        NavigationLink { DetailsView(item: movie)}
                        label: {
                            VStack(alignment: .leading, spacing: 10) {
                                KFImage(URL(string: movie.attributes.poster))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: itemWidth, alignment: .bottom)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(movie.attributes.title)
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .frame(height:20)
                                    Text(movie.attributes.runningTime)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(width: itemWidth)
                        }.buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct MovieAll: View {
    let movies: [MovieDataWrapper]
    
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
                Text("All Collections")
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
                ForEach(movies) { movie in
                    NavigationLink(destination: DetailsView(item: movie)) {
                        VStack(spacing: 10) {
                            KFImage(URL(string: movie.attributes.poster))
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(movie.attributes.title)
                                    .font(.title3)
                                    .lineLimit(2)
                                    .fontWeight(.medium)
                                
                                Text(movie.attributes.runningTime)
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
//    MovieView()
//}
