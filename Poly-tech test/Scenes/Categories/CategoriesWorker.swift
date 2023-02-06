//
//  CategoriesWorker.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class CategoriesWorker {
    func fetchCategories(completion: @escaping(Result<[BooksList], Error>) -> Void) {
        NetworkService.shared.fetchAllBooks { result in
            switch result {
            case .success(let results):
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCategoriesFromMemory(completion: @escaping(Result<[BooksList], Error>) -> Void) {
        CoreDataService.shared.getCategories { result in
            switch result {
            case .success(let booksList):
                completion(.success(booksList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveCategories(_ categories: [BooksList], completion: @escaping (Error?) -> Void) {
        CoreDataService.shared.saveCategories(categories) { error in
            if let error = error {
                completion(error)
            }
            completion(nil)
        }
    }
}
