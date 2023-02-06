//
//  CategoriesInteractor.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class CategoriesInteractor: CategoriesBusinessLogic, CategoriesDataStore {
    var presenter: CategoriesPresentationLogic?
    var worker: CategoriesWorker?
    var response: CategoriesResponse?
    
    // MARK: Fetch categories
    
    func fetchCategories() {
        worker = CategoriesWorker()
        worker?.fetchCategories(completion: { result in
            switch result {
            case .success(let categories):
                var response = CategoriesResponse(results: categories)
                self.response = response
                self.worker?.saveCategories(categories, completion: { error in
                    if let error = error {
                        response.error = error
                    }
                })
                self.presenter?.presentCategories(response: response)
            case .failure(_):
                self.worker?.fetchCategoriesFromMemory(completion: { result in
                    switch result {
                    case .success(let categories):
                        let response = CategoriesResponse(results: categories)
                        self.response = response
                        self.presenter?.presentCategories(response: response)
                    case .failure(let error):
                        let response = CategoriesResponse(error: error)
                        self.response = response
                        self.presenter?.presentCategories(response: response)
                    }
                })
            }
        })
    }
    
    // MARK: - Get categories
    
    func getCategories() {
        if let response = response {
            presenter?.presentCategories(response: response)
        }
    }
    
    // MARK: - Filter categories
    
    func filterCategories(with filter: String) {
        if let response = response {
            presenter?.presentFilteredCategories(response: response, filter: filter)
        }
    }
}
