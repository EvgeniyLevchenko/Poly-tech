//
//  CategorySection.swift
//  Poly-tech test
//
//  Created by QwertY on 04.02.2023.
//

import Foundation

enum CategorySection: Int, CaseIterable {
    case fiction
    case nonfiction
    case childrens
    case unspecified
    
    func description(usersCount: Int) -> String {
        switch self {
        case .fiction:
            return "Fiction"
        case .nonfiction:
            return "Nonfiction"
        case .childrens:
            return "Children's"
        case .unspecified:
            return ""
        }
    }
}
