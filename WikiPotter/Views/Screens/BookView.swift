//
//  BookView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 24/11/25.
//

import SwiftUI
import Kingfisher

struct BookView: View {
    @StateObject private var viewModel = BookViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    if viewModel.isLoading {
                        ProgressView("Loading Books...")
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
                        BookRecommendationView(books: viewModel.books)
                        // All Books
                        BookAll(books: viewModel.books)
                    }
                }
            }
            .navigationTitle(Text("Books"))
        }
        .task {
            await viewModel.loadBooks()
        }
    }
}

struct BookRecommendationView: View {
    // No need for Binding, we are just reading data
    let books: [BookDataWrapper]
    
    // Computed property for clean layout logic
    private var itemWidth: CGFloat {
        UIScreen.main.bounds.width - 60
    }
   
    var body: some View {
        VStack(spacing: 15) { // Added container for Header + List
            // Title
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
                    ForEach(books) { book in
                        VStack(alignment: .leading, spacing: 10) {
                            KFImage(URL(string: book.attributes.cover))
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth, height: itemWidth/1.3, alignment: .bottom)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(book.attributes.title)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                Text(book.attributes.author)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(width: itemWidth)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct BookAll: View {
    let books: [BookDataWrapper]
    
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
                ForEach(books) { book in
                    VStack(spacing: 10) {
                        KFImage(URL(string: book.attributes.cover))
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemWidth)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(book.attributes.title)
                                .font(.title3)
                                .lineLimit(2)
                                .fontWeight(.medium)
                            
                            Text(book.attributes.author)
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(width: itemWidth)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    BookView()
}
