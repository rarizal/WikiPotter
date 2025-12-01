//
//  MovieViewModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation
import Combine

@MainActor
class MovieViewModel: ObservableObject {
    
    @Published var movies: [MovieDataWrapper] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service = MovieService()
    
    func loadMovies() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let fetchedMovies = try await service.getMovies()
            self.movies = fetchedMovies
        } catch MovieError.invalidData {
            self.errorMessage = "Failed to parse data"
        } catch MovieError.invalidURL {
            self.errorMessage = "Invalid URL"
        } catch MovieError.invalidResponse {
            self.errorMessage = "Invalid response from server"
        } catch {
            self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
}
