//
//  CategoriesRoutingLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol CategoriesRoutingLogic {
    func routeToBookViewController(forCategoryItem categoryItem: Category, itemAt indexPath: IndexPath)
}
