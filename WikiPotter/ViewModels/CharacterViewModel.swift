//
//  CharacterViewModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation
import Combine

@MainActor
class CharacterViewModel: ObservableObject {
    
    @Published var characters: [CharacterDataWrapper] = []
    @Published var pagination: CharacterPaginationWrapper?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isAccending: Bool = true
    
    private let service = CharacterService()
    
    func loadCharacters() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let fetchedCharacters = try await service.getCharacters(isAscending: self.isAccending)
            self.characters = fetchedCharacters
        } catch CharacterError.invalidURL {
            self.errorMessage = "Invalid URL"
        } catch CharacterError.invalidData {
            self.errorMessage = "Invalid Data"
        } catch CharacterError.invalidResponse {
            self.errorMessage = "Invalid Response from server"
        } catch {
            self.errorMessage = "Unknown Error: \(error.localizedDescription)"
        }
        self.isLoading = false
    }
    
    func sortToggle() async {
        self.isAccending.toggle()
        await loadCharacters()

    }
}
