//
//  UIBarButtonItem+CustomView.swift
//  CarrotHomeTab
//
//  Created by Yuhyeon Kim on 2023/01/19.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfiguration, width: CGFloat? = nil) -> UIBarButtonItem {
        let customView = CustomeBarItem(config: config)
        if let width = width {
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        return barButtonItem
    }
}
