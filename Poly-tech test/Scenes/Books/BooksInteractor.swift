//
//  BooksInteractor.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class BooksInteractor: BooksBusinessLogic, BooksDataStore {
    var presenter: BooksPresentationLogic?
    var worker: BooksWorker?
    var response: BooksResponse?
    
    // MARK: Get books list
    
    func getBooks() {
        let worker = BooksWorker()
        if var response = response {
            let booksList = response.booksList
            if !booksList.booksInfo.isEmpty {
                worker.saveBooks(for: booksList, completion: { error in
                    if let error = error {
                        self.response?.error = error
                    }
                })
                presenter?.presentBooksList(response: response)
                return
            }
            
            worker.getBooks(for: booksList) { result in
                switch result {
                case .success(let books):
                    response.booksList.booksInfo = books
                    var booksList = response.booksList
                    booksList.booksInfo = books
                    let sectionIndex = response.sectionIndex
                    print("booksp")
                    print(books)
                    let response = BooksResponse(booksList: booksList, sectionIndex: sectionIndex)
                    self.presenter?.presentBooksList(response: response)
                case .failure(let error):
                    response.error = error
                    self.presenter?.presentBooksList(response: response)
                }
            }
        }
    }
    
    // MARK: Filter books list
    
    func filterBooks(with filter: String) {
        if let response = response {
            presenter?.presentFilteredBooksList(response: response, filter: filter)
            return
        }
    }
}
