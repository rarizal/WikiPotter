//
//  SpellModels.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation


struct SpellDataResponse: Decodable {
    let data : [SpellDataWrapper]
}

struct SpellDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let type: String
    let attributes: SpellModel
    
    // Detail Protocol
    var name: String {
        attributes.name
    }
    var image: String {
        attributes.image ?? "noSpell"
    }
    var description: String {
        attributes.category ?? "No Category"
    }
}

struct SpellModel: Decodable {
    let name: String
    let image: String?
    let category: String?
}

enum SpellError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    
}
