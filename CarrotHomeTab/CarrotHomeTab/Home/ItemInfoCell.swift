//
//  ItemInfoCell.swift
//  CarrotHomeTab
//
//  Created by Yuhyeon Kim on 2023/01/22.
//

// [✅] 셀에서 price에 콤마 표시하게 넘버 포멧팅
// [✅] 셀에서 이미지 업데이트 및 cornerRadiuse 설정

import UIKit
import Kingfisher

class ItemInfoCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numOfChatLabel: UILabel!
    @IBOutlet weak var numOfLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 10
        thumbnail.layer.masksToBounds = true
        thumbnail.tintColor = .systemGray
    }
    
    func configure(item: ItemInfo) {
        titleLabel.text = item.title
        descriptionLabel.text = item.location
        priceLabel.text = "\(formatNumber(item.price))원"
        numOfChatLabel.text = "\(item.numOfChats)"
        numOfLikeLabel.text = "\(item.numOfLikes)"
        thumbnail.kf.setImage(with: URL(string: item.thumbnailURL), placeholder: UIImage(systemName: "hands.sparkles.fill"))
    }
    
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        
        return result
    }
}
