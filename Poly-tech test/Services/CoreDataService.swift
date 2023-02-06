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
    
    func saveCategories(_ categories: [BooksList], completion: @escaping (Error?) -> Void) {
        do {
            if let categoryItems = try context?.fetch(CategoryItem.fetchRequest()) {
                if categoryItems.isEmpty {
                    guard let context = context else {
                        completion(CoreDataError.cannotGetContext)
                        return
                    }
                    for category in categories {
                        let newCategoryItem = CategoryItem(context: context)
                        newCategoryItem.booksList = category
                    }
                } else {
                    for (categoryItem, category) in zip(categoryItems, categories) {
                        if categoryItem.listName != category.listName {
                            categoryItem.booksList = category
                        }
                    }
                }

                try context?.save()
                completion(nil)
                return
            }
        } catch {
            completion(error)
            return
        }
        completion(CoreDataError.cannotAccessData)
    }
    
    func getBooks(for category: BooksList, completion: @escaping(Result<[BookInfo], Error>) -> Void) {
       do {
            if let booksItems = try context?.fetch(BookItem.fetchRequest()) {
                let books = booksItems.filter({ bookItem in
                    bookItem.listName == category.listName
                }).map { $0.book }
                completion(.success(books))
                return
            }
        } catch {
            completion(.failure(error))
            return
        }
        completion(.failure(CoreDataError.cannotAccessData))
    }
    
    func saveBooks(_ booksList: BooksList, completion: @escaping(Error?) -> Void) {
        do {
            let books = booksList.booksInfo
            let listName = booksList.listName
            guard let context = context else {
                completion(CoreDataError.cannotGetContext)
                return
            }
            var booksItems = try context.fetch(BookItem.fetchRequest())
            if booksItems.isEmpty {
                for book in books {
                    let newBookItem = BookItem(context: context)
                    newBookItem.book = book
                    newBookItem.listNameStr = listName
                }
            } else {
                for book in books {
                    if !booksItems.contains(where: { bookItem in
                        bookItem.book.title == book.title
                    }) {
                        let newBookItem = BookItem(context: context)
                        newBookItem.book = book
                        newBookItem.listNameStr = listName
                        booksItems.append(newBookItem)
                    }
                }
            }
            
            try context.save()
            completion(nil)
            return
        } catch {
            completion(error)
            return
        }
    }
}

