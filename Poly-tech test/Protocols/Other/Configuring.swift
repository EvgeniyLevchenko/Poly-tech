//
//  Configuring.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import Foundation

protocol SelfConfiguring {
    static var reuseID: String { get }
    func configure<T: Hashable>(with value: T)
}
