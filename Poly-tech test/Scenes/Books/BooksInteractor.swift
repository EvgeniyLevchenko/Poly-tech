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
        guard var response = response else { return }
        let category = response.booksList
        if !response.booksList.booksInfo.isEmpty {
            worker.saveBooks(for: category) { error in
                if let error = error {
                    response.error = error
                }
            }
            presenter?.presentBooksList(response: response)
        } else {
            worker.getBooks(for: category) { result in
                switch result {
                case .success(let books):
                    response.booksList.booksInfo = books
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
