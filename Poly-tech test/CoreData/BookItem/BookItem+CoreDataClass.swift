//
//  BookItem+CoreDataClass.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//
//

import Foundation
import CoreData

@objc(BookItem)
public class BookItem: NSManagedObject {
    var book: BookInfo {
        get {
            let book = BookInfo(
                rank: Int(rank),
                rankLastWeek: 0,
                weeksOnList: 0,
                asterisk: 0,
                dagger: 0,
                primaryIsbn10: "",
                primaryIsbn13: "",
                publisher: publisher ?? "",
                description: descriptionStr ?? "",
                price: "",
                title: name ?? "",
                author: author ?? "",
                contributor: "",
                contributorNote: "",
                bookImage: imageURL ?? "",
                bookImageWidth: 0,
                bookImageHeight: 0,
                amazonProductURL: "",
                ageGroup: "",
                bookReviewLink: "",
                firstChapterLink: "",
                sundayReviewLink: "",
                articleChapterLink: "",
                isbns: [],
                buyLinks: [BuyLink(name: "", url: buyURL ?? "")],
                bookURI: ""
            )
            return book
        }
        set {
            self.name = newValue.title
            self.descriptionStr = newValue.description
            self.author = newValue.author
            self.publisher = newValue.publisher
            self.imageURL = newValue.bookImage
            self.rank = Int32(newValue.rank)
            self.buyURL = newValue.buyLinks.first?.url
        }
    }
    
    var listNameStr: String {
        get {
            return listName ?? ""
        }
        set {
            listName = newValue
        }
    }
}
