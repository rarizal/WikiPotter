//
//  CharacterService.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

class CharacterService {
    func getCharacters() async throws -> [CharacterDataWrapper] {
        
        let characterEndPoint = "https://api.potterdb.com/v1/characters?sort=name"
        
        guard let url = URL(string: characterEndPoint) else {
            throw CharacterError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CharacterError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let characterResponse = try decoder.decode(CharacterDataResponse.self, from: data)
            return characterResponse.data
        } catch {
            print("Invalid data from service Characters")
            throw CharacterError.invalidData
        }
    }
}
