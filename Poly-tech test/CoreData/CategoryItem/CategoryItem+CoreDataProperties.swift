//
//  CategoryItem+CoreDataProperties.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//
//

import Foundation
import CoreData


extension CategoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryItem> {
        return NSFetchRequest<CategoryItem>(entityName: "CategoryItem")
    }

    @NSManaged public var listName: String?
    @NSManaged public var listNameEncoded: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension CategoryItem {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookItem)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookItem)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension CategoryItem : Identifiable {

}
