//
//  BookModels.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

struct CharacterDataResponse: Decodable {
    let data: [CharacterDataWrapper]
}

struct CharacterDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let attributes: CharacterModel
    
    // Detail Protocol
    var name: String { attributes.name ?? "Name" }
    var image: String { attributes.image ?? "Image" }
    var description: String { attributes.house ?? "House" }
}

struct CharacterModel: Decodable {
    let name: String?
    let gender:String?
    let house: String?
    let image: String?
}

enum CharacterError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
