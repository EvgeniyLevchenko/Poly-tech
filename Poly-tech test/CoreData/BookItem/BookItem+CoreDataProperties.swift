//
//  BookItem+CoreDataProperties.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//
//

import Foundation
import CoreData


extension BookItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookItem> {
        return NSFetchRequest<BookItem>(entityName: "BookItem")
    }

    @NSManaged public var author: String?
    @NSManaged public var buyURL: String?
    @NSManaged public var descriptionStr: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var listName: String?
    @NSManaged public var name: String?
    @NSManaged public var publisher: String?
    @NSManaged public var rank: Int32
    @NSManaged public var category: CategoryItem?

}

extension BookItem : Identifiable {

}
