//
//  CategoryItem+CoreDataClass.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//
//

import Foundation
import CoreData

@objc(CategoryItem)
public class CategoryItem: NSManagedObject {
    var booksList: BooksList {
        get {
            let booksList = BooksList(
                listName: listName ?? "",
                listNameEncoded: listNameEncoded ?? "",
                bestsellersDate: "",
                publishedDate: publishedDate ?? "",
                publishedDateDescription: "",
                nextPublishedDate: "",
                previousPublishedDate: "",
                displayName: "",
                normalListEndsAt: 0,
                updated: "",
                booksInfo: [],
                corrections: []
            )
            
            return booksList
        }
        set {
            listName = newValue.listName
            publishedDate = newValue.publishedDate
            listNameEncoded = newValue.listNameEncoded
        }
    }
}
