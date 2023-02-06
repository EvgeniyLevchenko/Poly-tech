//
//  BookInfo.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation

// MARK: - BookInfo
struct BookInfo: Codable {
    let rank, rankLastWeek, weeksOnList, asterisk: Int
    let dagger: Int
    let primaryIsbn10, primaryIsbn13, publisher, description: String
    let price, title, author, contributor: String
    let contributorNote: String
    let bookImage: String
    let bookImageWidth, bookImageHeight: Int
    let amazonProductURL: String
    let ageGroup, bookReviewLink, firstChapterLink, sundayReviewLink: String
    let articleChapterLink: String
    let isbns: [Isbn]
    let buyLinks: [BuyLink]
    let bookURI: String

    enum CodingKeys: String, CodingKey {
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case asterisk, dagger
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher, description, price, title, author, contributor
        case contributorNote = "contributor_note"
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case amazonProductURL = "amazon_product_url"
        case ageGroup = "age_group"
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
        case isbns
        case buyLinks = "buy_links"
        case bookURI = "book_uri"
    }
}
