//
//  PotionService.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation

class PotionService {
    func getPotions() async throws -> [PotionDataWrapper] {
        let potionEndPint = "https://api.potterdb.com/v1/potions"
        
        guard let url = URL(string: potionEndPint) else {
            throw PotionError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PotionError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let potionResponse = try decoder.decode(PotionDataResponse.self, from: data)
            return potionResponse.data
        } catch {
            throw PotionError.invalidData
        }
    }
}
