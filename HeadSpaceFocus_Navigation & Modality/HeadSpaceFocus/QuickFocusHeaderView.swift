//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 김유현 on 2022/12/30.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
