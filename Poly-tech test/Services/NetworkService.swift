//
//  NetworkService.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import Foundation
import Alamofire

class NetworkService: Networking {
    
    static let shared = NetworkService()
    
    private var apiKey: String {
        get {
            let resourceName = "Books-Info"
            let resourceType = "plist"
            guard let filePath = Bundle.main.path(
                forResource: resourceName,
                ofType: resourceType
            ) else {
                let errorMessage = "Couldn't find file 'Books-Info.plist'."
                fatalError(errorMessage)
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            let key = "API_KEY"
            guard let value = plist?.object(forKey: key) as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'Books-Info.plist'.")
            }
            
            if (value.starts(with: "_")) {
                fatalError("Register for a NYT's developer account and get an API key at https://developer.nytimes.com.")
            }
            
            return value
        }
    }
    
    private init() {}
    
    private func getRequestURL(for books: BookType) -> String {
        let urlBase = "https://api.nytimes.com/svc/books/v3/lists/"
        let booksType = books.typeEncoded
        let urlEnding = ".json?api-key="
        let strUrl = urlBase + booksType + urlEnding + apiKey
        return strUrl
    }

    func fetchBooks(of bookType: BookType, completion: @escaping (Result<BooksList, Error>) -> Void) {
        let url = getRequestURL(for: bookType)
        AF.request(url).responseDecodable(of: NetworkResponse.self) { response in
            switch response.result {
            case .success(let response):
                let results = response.booksList
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllBooks(completion: @escaping (Result<[BooksList], Error>) -> Void) {
        let allCategories = BookType.allCases
        var results = [BooksList]()
        let group = DispatchGroup()
        for category in allCategories {
            group.enter()
            self.fetchBooks(of: category) { result in
                switch result {
                case .success(let result):
                    results.append(result)
                case .failure(_):
                    break
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if !results.isEmpty {
                completion(.success(results))
            } else {
                let error = NetworkError.fetchError
                completion(.failure(error))
            }
        }
    }
}
