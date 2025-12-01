//
//  PotionViewModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation
import Combine

@MainActor
class PotionViewModel: ObservableObject {
    @Published var potions: [PotionDataWrapper] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service = PotionService()
    
    func loadPotions() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let fetchedPotions = try await service.getPotions()
            self.potions = fetchedPotions
        } catch PotionError.invalidURL {
            self.errorMessage = "Invalid URL"
        } catch PotionError.invalidData {
            self.errorMessage = "Failed to fetch spells"
        } catch PotionError.invalidResponse {
            self.errorMessage = "Invalid response"
        } catch {
            self.errorMessage = "Failed to fetch spells \(error.localizedDescription)"
        }
        self.isLoading = false
    }
}


