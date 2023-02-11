//
//  CoreDataService.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit
import CoreData

class CoreDataService: DataStoring {
    
    static let shared = CoreDataService()
    
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    private init() {}
    
    private func save() throws {
        guard let context = context else {
            throw CoreDataError.cannotGetContext
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
    
    private func createCategoryItem(with category: BooksList) throws {
        guard let context = context else {
            throw CoreDataError.cannotGetContext
        }
        let newCategoryItem = CategoryItem(context: context)
        newCategoryItem.booksList = category
    }
    
    private func createBookItem(with book: BookInfo, for category: CategoryItem) throws {
        guard let context = context else {
            throw CoreDataError.cannotGetContext
        }
        let bookItem = BookItem(context: context)
        bookItem.book = book
        bookItem.listName = category.listName
        category.addToBooks(bookItem)
    }
    
    func saveCategories(_ categories: [BooksList], completion: @escaping (Error?) -> Void) {
        do {
            if let categoryItems = try context?.fetch(CategoryItem.fetchRequest()) {
                if categoryItems.isEmpty {
                    for category in categories {
                        try createCategoryItem(with: category)
                    }
                } else {
                    for (categoryItem, category) in zip(categoryItems, categories) {
                        if categoryItem.listName != category.listName {
                            categoryItem.booksList = category
                        }
                    }
                }
                try save()
                completion(nil)
                return
            }
        } catch {
            completion(error)
            return
        }
        completion(CoreDataError.cannotAccessData)
    }
    
    func getCategories(completion: @escaping(Result<[BooksList], Error>) -> Void) {
        do {
            if let categoryItems = try context?.fetch(CategoryItem.fetchRequest()) {
                let categories = categoryItems.map { $0.booksList }
                completion(.success(categories))
                return
            }
        } catch {
            completion(.failure(error))
            return
        }
        completion(.failure(CoreDataError.cannotAccessData))
    }
    
    func saveBooks(_ category: BooksList, completion: @escaping(Error?) -> Void) {
        do {
            guard let context = context else {
                completion(CoreDataError.cannotGetContext)
                return
            }
            
            let categoryItems = try context.fetch(CategoryItem.fetchRequest())
            guard let filteredCategoryItem = categoryItems.filter( { categoryItem in
                categoryItem.listName == category.listName
            }).first else {
                return
            }
            
            let books = category.booksInfo
            let booksItems = try context.fetch(BookItem.fetchRequest())
            for book in books {
                if !booksItems.contains(where: { $0.book.title == book.title }) {
                    try createBookItem(with: book, for: filteredCategoryItem)
                }
            }
            
            try save()
            completion(nil)
            return
        } catch {
            completion(error)
            return
        }
    }
    
    func getBooks(for category: BooksList, completion: @escaping(Result<[BookInfo], Error>) -> Void) {
        do {
            guard let context = context else {
                completion(.failure(CoreDataError.cannotGetContext))
                return
            }
            
            let categoryItems = try context.fetch(CategoryItem.fetchRequest())
            guard let filteredCategoryItem = categoryItems.filter( { categoryItem in
                categoryItem.listName == category.listName
            }).first else {
                return
            }
            guard let listName = filteredCategoryItem.listName else {
                completion(.failure(CoreDataError.cannotAccessData))
                return
            }
            
            let request = BookItem.fetchRequest()
            let format = "listName = %@"
            let predicate = NSPredicate(format: format, listName)
            request.predicate = predicate
            let key = "rank"
            let sortDescriptor = NSSortDescriptor(key: key, ascending: true)
            request.sortDescriptors = [sortDescriptor]
            let fetchedBookItems = try context.fetch(request)
            
            let books = fetchedBookItems.filter({ bookItem in
                bookItem.listName == category.listName
            }).map({ $0.book })
            completion(.success(books))
        } catch {
            completion(.failure(error))
            return
        }
    }
}

