//
//  BookViewModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation
import Combine

@MainActor
class BookViewModel: ObservableObject {
    
    @Published var books: [BookDataWrapper] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service = BookService()
    
    func loadBooks() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let fetchedBooks = try await service.getBooks()
            self.books = fetchedBooks
        } catch BookError.invalidURL {
            self.errorMessage = "Invalid URL"
        } catch BookError.invalidData {
            self.errorMessage = "Invalid Data"
        } catch BookError.invalidResponse {
            self.errorMessage = "Invalid Response from server"
        } catch {
            self.errorMessage = "Unknown error: \(error.localizedDescription)"
        }
        
        self.isLoading = false
    }
}

