//
//  CategoriesPresenter.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class CategoriesPresenter: CategoriesPresentationLogic {
    weak var viewController: CategoriesDisplayLogic?
    
    // MARK: Present categories
    
    func presentCategories(response: CategoriesResponse) {
        let viewModel = CategoriesViewModel(response: response)
        if let error = viewModel.error {
            viewController?.displayAlert(with: "Error!", message: error.localizedDescription)
            return
        }
        viewController?.displayCategories(viewModel: viewModel)
    }
    
    // MARK: Present filtered categories
    
    func presentFilteredCategories(response: CategoriesResponse, filter: String) {
        var viewModel = CategoriesViewModel(response: response)
        
        let filteredFictionCategories = viewModel.fictionCategories.filter { category in
            category.contains(filter: filter)
        }
        
        let filteredNonfictionCategories = viewModel.nonfictionCategories.filter { category in
            category.contains(filter: filter)
        }
        
        let filteredChildrensCategories = viewModel.childrensCategories.filter { category in
            category.contains(filter: filter)
        }
        
        viewModel.fictionCategories = filteredFictionCategories
        viewModel.nonfictionCategories = filteredNonfictionCategories
        viewModel.childrensCategories = filteredChildrensCategories
        viewController?.displayCategories(viewModel: viewModel)
    }
}
