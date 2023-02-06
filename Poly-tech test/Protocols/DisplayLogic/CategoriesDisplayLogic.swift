//
//  CategoriesDisplayLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol CategoriesDisplayLogic: AnyObject {
    func displayCategories(viewModel: CategoriesViewModel)
    func displayAlert(with title: String, message: String)
}
