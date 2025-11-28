//
//  BookService.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

class BookService {
    func getBooks() async throws -> [BookDataWrapper] {
       let bookEndPoint = "https://api.potterdb.com/v1/books"
    
        guard let url = URL(string: bookEndPoint) else {
            throw BookError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw BookError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let bookResponse = try decoder.decode(BookDataResponse.self, from: data)
            return bookResponse.data
        } catch {
            throw BookError.invalidData
        }
    }
}
