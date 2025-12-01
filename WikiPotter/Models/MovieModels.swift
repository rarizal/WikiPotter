//
//  MovieModels.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

struct MovieDataResponse: Decodable {
    let data: [MovieDataWrapper]
}

struct MovieDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let type: String
    let attributes: MovieModel
    
    // Detail Protocol
    var name: String {attributes.title}
    var image: String {attributes.poster}
    var description: String {attributes.summary}
}

struct MovieModel: Decodable {
    let title: String
    let poster: String
    let summary: String
    let runningTime: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case poster
        case summary
        case runningTime = "running_time"
    }
}

enum MovieError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}
