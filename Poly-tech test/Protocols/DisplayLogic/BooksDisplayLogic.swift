//
//  BooksDisplayLogic.swift
//  Poly-tech test
//
//  Created by QwertY on 07.02.2023.
//

import Foundation

protocol BooksDisplayLogic: AnyObject {
    func displayBooks(viewModel: BooksViewModel)
    func displayAlert(with title: String, message: String)
}
