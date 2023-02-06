//
//  CategoriesModels.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

typealias CategoriesResponse = Categories.Response
typealias CategoriesViewModel = Categories.ViewModel
typealias Category = Categories.Category

enum Categories
{
    // MARK: Use cases
    struct Response {
        var results: [BooksList] = []
        var error: Error? = nil
    }
    
    struct ViewModel {
        var fictionCategories: [Category] = []
        var nonfictionCategories: [Category] = []
        var childrensCategories: [Category] = []
        
        var error: Error? = nil
        
        init(response: Response) {
            if let error = response.error {
                self.error = error
            } else {
                let results = response.results
                for result in results {
                    let listNameEncoded = result.listNameEncoded
                    
                    if let _ = BookType.Fiction(rawValue: listNameEncoded) {
                        let categoryName = result.listName
                        let publishedDate = result.publishedDate
                        let category = Category(categoryName: categoryName, publishedDate: publishedDate)
                        fictionCategories.append(category)
                    }
                    
                    if let _ = BookType.Nonfiction(rawValue: listNameEncoded) {
                        let categoryName = result.listName
                        let publishedDate = result.publishedDate
                        let category = Category(categoryName: categoryName, publishedDate: publishedDate)
                        nonfictionCategories.append(category)
                    }
                    
                    if let _ = BookType.Childrens(rawValue: listNameEncoded) {
                        let categoryName = result.listName
                        let publishedDate = result.publishedDate
                        let category = Category(categoryName: categoryName, publishedDate: publishedDate)
                        childrensCategories.append(category)
                    }
                }
            }
        }
    }
    
    struct Category: Hashable {
        let categoryName: String
        let publishedDate: String
        
        func contains(filter: String?) -> Bool {
            guard let filter = filter else { return true }
            if filter.isEmpty { return true }
            let lowercasedFilter = filter.lowercased()
            return categoryName.lowercased().contains(lowercasedFilter)
        }
    }
}
