//
//  CategoriesPresentationLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol CategoriesPresentationLogic {
    func presentCategories(response: CategoriesResponse)
    func presentFilteredCategories(response: CategoriesResponse, filter: String)
}
