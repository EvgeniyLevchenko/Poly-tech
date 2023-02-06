//
//  NetworkError.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case fetchError
    
    var errorDescription: String? {
        switch self {
        case .fetchError:
            return NSLocalizedString("Fetch error", comment: "")
        }
    }
}
