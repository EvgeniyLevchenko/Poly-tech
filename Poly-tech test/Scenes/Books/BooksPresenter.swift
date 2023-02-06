//
//  BooksPresenter.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class BooksPresenter: BooksPresentationLogic {
    weak var viewController: BooksDisplayLogic?
    
    // MARK: Present books list
    
    func presentBooksList(response: BooksResponse) {
        if let error = response.error {
            viewController?.displayAlert(with: "Error!", message: error.localizedDescription)
        }
        let viewModel = BooksViewModel(response: response)
        viewController?.displayBooks(viewModel: viewModel)
    }
    
    // MARK: Present filtered books list
    
    func presentFilteredBooksList(response: BooksResponse, filter: String) {
        var viewModel = BooksViewModel(response: response)
        let filteredBooks = viewModel.books.filter { book in
            book.contains(filter: filter)
        }
        viewModel.books = filteredBooks
        viewController?.displayBooks(viewModel: viewModel)
    }
}
