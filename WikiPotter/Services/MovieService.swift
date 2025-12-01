//
//  MovieService.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation

class MovieService {
    func getMovies() async throws -> [MovieDataWrapper] {
        let movieEndPoint = "https://api.potterdb.com/v1/movies"
        
        guard let url = URL(string: movieEndPoint) else {
           throw MovieError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let movieResponse = try decoder.decode(MovieDataResponse.self, from: data)
            return movieResponse.data
        } catch {
            throw MovieError.invalidData
        }
        
    }
}
