//
//  BooksPresentationLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol BooksPresentationLogic {
    func presentBooksList(response: BooksResponse)
    func presentFilteredBooksList(response: BooksResponse, filter: String)
}
