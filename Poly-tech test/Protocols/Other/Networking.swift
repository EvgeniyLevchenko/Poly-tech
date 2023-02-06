//
//  Networking.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation

protocol Networking {
    func fetchBooks(of bookType: BookType, completion: @escaping(Result<BooksList, Error>) -> Void)
    func fetchAllBooks(completion: @escaping(Result<[BooksList], Error>) -> Void)
}
