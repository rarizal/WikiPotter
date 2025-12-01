//
//  PotionModel.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 01/12/25.
//

import Foundation

struct PotionDataResponse: Decodable {
    let data : [PotionDataWrapper]
}

struct PotionDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let attributes: PotionModel
    
    // Detail Protocol
    var name: String {attributes.name}
    var image: String {attributes.image ?? "noPotion"}
    var description: String {attributes.difficulty ?? "Unknown"}
}

struct PotionModel: Decodable {
    let name: String
    let image: String?
    let difficulty: String?
}

enum PotionError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
