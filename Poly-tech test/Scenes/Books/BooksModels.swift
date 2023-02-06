//
//  BooksModels.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

typealias BooksResponse = Books.Response
typealias BooksViewModel = Books.ViewModel
typealias Book = Books.Book

enum Books {
    // MARK: Use cases
    
    struct Response {
        var booksList: BooksList
        var sectionIndex: Int
        var error: Error? = nil
    }
    
    struct ViewModel {
        var books: [Book] = []
        let title: String?
        
        init(response: Response) {
            let booksList = response.booksList
            self.title = booksList.listName
            let listName = response.booksList.listName
            let booksInfo = booksList.booksInfo
            for bookInfo in booksInfo {
                let name = bookInfo.title
                let description = bookInfo.description
                let author = bookInfo.author
                let publisher = bookInfo.publisher
                let imageURL = bookInfo.bookImage
                let rank = bookInfo.rank
                guard let buyLink = bookInfo.buyLinks.first(where: { buyLink in
                    let booksServiceName = "Apple Books"
                    return booksServiceName == buyLink.name
                }) else {
                    return
                }
                let buyURL = buyLink.url
                
                let book = Book(listName: listName, name: name, description: description, author: author, publisher: publisher, imageURL: imageURL, rank: rank, buyURL: buyURL)
                self.books.append(book)
            }
        }
    }
    
    struct Book: Hashable {
        let listName: String
        let name: String
        let description: String
        let author: String
        let publisher: String
        let imageURL: String
        let rank: Int
        let buyURL: String
        
        func contains(filter: String?) -> Bool {
            guard let filter = filter else { return true }
            if filter.isEmpty { return true }
            let lowercasedFilter = filter.lowercased()
            return name.lowercased().contains(lowercasedFilter)
        }
    }
}
