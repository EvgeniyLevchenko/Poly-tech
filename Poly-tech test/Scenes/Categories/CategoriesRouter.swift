//
//  CategoriesRouter.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class CategoriesRouter: CategoriesRoutingLogic, CategoriesDataPassing {
    weak var viewController: CategoriesViewController?
    var dataStore: CategoriesDataStore?
    
    // MARK: Routing
    
    func routeToBookViewController(forCategoryItem categoryItem: Category, itemAt indexPath: IndexPath) {
        let booksViewController = BooksViewController()
        var booksDataStore = booksViewController.router?.dataStore
        guard let viewController = viewController else { return }
        passDataToBooksViewController(forCategoryItem: categoryItem, itemAt: indexPath, source: dataStore, destination: &booksDataStore)
        navigateToBooksViewController(source: viewController, destination: booksViewController)
    }
    
    // MARK: Navigation
    
    func navigateToBooksViewController(source: CategoriesViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToBooksViewController(forCategoryItem categoryItem: Category, itemAt indexPath: IndexPath, source: CategoriesDataStore?, destination: inout BooksDataStore?) {
        let categoryName = categoryItem.categoryName
        guard let booksList = source?.response?.results.first(where: { result in
            result.listName == categoryName
        }) else {
            return
        }
        
        let booksResponse = BooksResponse(booksList: booksList, sectionIndex: indexPath.section)
        destination?.response = booksResponse
    }
}
