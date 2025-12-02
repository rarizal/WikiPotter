//
//  BookModels.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

struct CharacterDataResponse: Decodable {
    let data: [CharacterDataWrapper]
    let meta: CharacterPaginationWrapper
    // let links: CharacterPagination
}

// Character Data Wrapper
struct CharacterDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let attributes: CharacterModel
    
    // Detail Protocol
    var name: String { attributes.name ?? "Name" }
    var image: String { attributes.image ?? "noAvatar" }
    var description: String { attributes.house ?? "No House" }
}

// Pagination Data Wrapper
struct CharacterPaginationWrapper: Decodable {
    let pagination: CharacterPagination
}

// Character Data
struct CharacterModel: Decodable {
    let name: String?
    let gender:String?
    let house: String?
    let image: String?
}
// Pagination Data
struct CharacterPagination: Decodable {
    let current: Int
    let next: Int
}

enum CharacterError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
