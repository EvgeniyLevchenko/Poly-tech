//
//  UIImageView + Extension.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(contentMode: UIView.ContentMode, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 20) {
        self.init()
        
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.tintColor = .mainPurple()
    }
}
