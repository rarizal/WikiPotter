//
//  BookModels.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 25/11/25.
//

import Foundation

struct BookDataResponse: Decodable {
    let data: [BookDataWrapper]
}

struct BookDataWrapper: Decodable, Identifiable, DetailProtocol {
    let id: String
    let type: String
    let attributes: BookModel
    
    // Detail Protocol
    var name: String { attributes.title }
    var image: String {attributes.cover}
    var description: String {attributes.summary}
}

struct BookModel: Decodable {
    let title: String
    let summary:String
    let cover: String
    let author: String
    let pages: Int
    let release_date: String
}

enum BookError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
