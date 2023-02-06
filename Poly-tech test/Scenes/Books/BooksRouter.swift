//
//  BooksRouter.swift
//  Poly-tech test
//
//  Created by QwertY on 02.02.2023.
//

import UIKit

class BooksRouter: NSObject, BooksRoutingLogic, BooksDataPassing {
    weak var viewController: BooksViewController?
    var dataStore: BooksDataStore?
    
    // MARK: Routing
    
    func routeToWebViewController(with url: String) {
        guard let url = URL(string: url) else { return }
        let webViewController = WebViewController(url: url)
        navigateToSomewhere(source: viewController!, destination: webViewController)
    }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: BooksViewController?, destination: UIViewController) {
        source?.present(destination, animated: true)
    }
}
