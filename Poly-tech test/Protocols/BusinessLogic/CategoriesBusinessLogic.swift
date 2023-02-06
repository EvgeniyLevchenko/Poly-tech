//
//  CategoriesBusinessLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol CategoriesBusinessLogic {
    func fetchCategories()
    func getCategories()
    func filterCategories(with filter: String)
}
