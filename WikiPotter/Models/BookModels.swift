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

struct BookDataWrapper: Decodable, Identifiable {
    let id: String
    let attributes: BookModel
}

struct BookModel: Decodable {
    let title: String
    let summary:String
    let cover: String
    let author: String
}

enum BookError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
