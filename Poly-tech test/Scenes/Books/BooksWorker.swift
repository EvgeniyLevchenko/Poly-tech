//
//  BooksWorker.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class BooksWorker {
    func saveBooks(for category: BooksList, completion: @escaping (Error?) -> Void) {
        CoreDataService.shared.saveBooks(category) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func getBooks(for category: BooksList, completion: @escaping(Result<[BookInfo], Error>) -> Void) {
        CoreDataService.shared.getBooks(for: category) { result in
            switch result {
            case .success(let books):
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
