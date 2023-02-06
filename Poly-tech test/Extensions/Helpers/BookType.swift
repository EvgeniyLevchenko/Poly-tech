//
//  BookType.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation

enum BookType: Hashable, CaseIterable {
    case fiction(Fiction)
    case nonfiction(Nonfiction)
    case childrens(Childrens)
    
    enum Fiction: String, CaseIterable {
        case combinedPrintAndEBook = "combined-print-and-e-book-fiction"
        case hardcover = "hardcover-fiction"
        case paperbackTrade = "trade-fiction-paperback"
    }

    enum Nonfiction: String, CaseIterable {
        case combinedPrintAndEBook = "combined-print-and-e-book-nonfiction"
        case hardcover = "hardcover-nonfiction"
        case paperback = "paperback-nonfiction"
        case adviceHowToAndMisc = "advice-how-to-and-miscellaneous"
    }

    enum Childrens: String, CaseIterable {
        case middleGradeHardcover = "childrens-middle-grade-hardcover"
        case seriesBooks = "series-books"
        case youngAdultHardcover = "young-adult-hardcover"
    }
    
    static var allCases: [BookType] = {
        [
            .fiction(.combinedPrintAndEBook),
            .fiction(.hardcover),
            .fiction(.paperbackTrade),
            .nonfiction(.combinedPrintAndEBook),
            .nonfiction(.hardcover),
            .nonfiction(.paperback),
            .nonfiction(.adviceHowToAndMisc),
            .childrens(.middleGradeHardcover),
            .childrens(.seriesBooks),
            .childrens(.youngAdultHardcover)
        ]
    }()

    var typeEncoded: String {
        switch self {
        case .fiction(let fiction):
            return fiction.rawValue
        case .nonfiction(let nonfiction):
            return nonfiction.rawValue
        case .childrens(let childrens):
            return childrens.rawValue
        }
    }
}

