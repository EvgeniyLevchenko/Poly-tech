//
//  DataStoring.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol DataStoring {
    func getCategories(completion: @escaping(Result<[BooksList], Error>) -> Void)
    func saveCategories(_ categories: [BooksList], completion: @escaping (Error?) -> Void)
    func getBooks(for category: BooksList, completion: @escaping(Result<[BookInfo], Error>) -> Void)
    func saveBooks(_ booksList: BooksList, completion: @escaping(Error?) -> Void)
}
