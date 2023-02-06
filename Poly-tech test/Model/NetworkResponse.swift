//
//  NetworkResponse.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation

// MARK: - NetworkResponse
struct NetworkResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let lastModified: String
    let booksList: BooksList

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case lastModified = "last_modified"
        case booksList = "results"
    }
}


