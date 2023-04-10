//
//  FrameWorkCell.swift
//  AppleFramework
//
//  Created by 김유현 on 2022/12/23.
//

import UIKit

class FrameWorkCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(_ framework: AppleFramework){
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
    
}
