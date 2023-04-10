//
//  ResultCell.swift
//  InstaSearchView
//
//  Created by 김유현 on 2022/12/23.
//

import UIKit

class ResultCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    func configure(_ imageName: String){
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
