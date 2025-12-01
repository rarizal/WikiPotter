//
//  SpellService.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation

class SpellService {
    func getSpells() async throws -> [SpellDataWrapper] {
        let spellEndPoint = "https://api.potterdb.com/v1/spells"
        
        guard let url = URL(string: spellEndPoint) else {
            throw SpellError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw SpellError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let spellResponse = try decoder.decode(SpellDataResponse.self, from: data)
            return spellResponse.data
        } catch {
            throw SpellError.invalidData
        }
    }
}
