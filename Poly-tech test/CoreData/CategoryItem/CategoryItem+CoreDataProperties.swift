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
    @NSManaged public var publishedDate: String?
    @NSManaged public var listNameEncoded: String?

}

extension CategoryItem : Identifiable {

}
