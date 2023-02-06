//
//  WebViewController.swift
//  Poly-tech test
//
//  Created by QwertY on 06.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var webView: WKWebView!
    private var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadPage()
    }
    
    private func setupView() {
        webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let topPadding = view.safeAreaInsets.top
        webView.frame = view.frame.inset(by: UIEdgeInsets(top: topPadding, left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0)))
    }
    
    private func loadPage() {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
