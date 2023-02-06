//
//  BooksList.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation

// MARK: - Results
struct BooksList: Codable {
    let listName, listNameEncoded, bestsellersDate, publishedDate: String
    let publishedDateDescription, nextPublishedDate, previousPublishedDate, displayName: String
    let normalListEndsAt: Int
    let updated: String
    var booksInfo: [BookInfo]
    let corrections: [String]

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case normalListEndsAt = "normal_list_ends_at"
        case booksInfo = "books"
        case updated, corrections
    }
}



