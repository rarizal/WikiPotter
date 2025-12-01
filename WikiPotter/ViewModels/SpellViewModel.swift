//
//  SpellViewModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//


import Foundation
import Combine

@MainActor
class SpellViewModel: ObservableObject {
    @Published var spells: [SpellDataWrapper] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service = SpellService()
    
    func loadSpells() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedSpells = try await service.getSpells()
            self.spells = fetchedSpells
        } catch SpellError.invalidData {
            errorMessage = "Invalid data."
        } catch SpellError.invalidResponse {
            errorMessage = "Invalid response from server."
        }  catch SpellError.invalidURL {
            errorMessage = "Invalid URL."
        } catch {
            errorMessage = "Failed to fetch spells \(error.localizedDescription)"
        }
        isLoading = false
    }
}
