//
//  HomeCell.swift
//  InstaSearchView
//
//  Created by 김유현 on 2022/12/23.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImageView: UIImageView!
    override func prepareForReuse() {
        super .prepareForReuse()
        homeImageView.image = nil
    }
    func configure(_ imageName: String) {
        homeImageView.image = UIImage(named: imageName)
    }
}
