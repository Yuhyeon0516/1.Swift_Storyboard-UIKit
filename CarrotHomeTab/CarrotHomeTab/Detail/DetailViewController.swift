//
//  DetailViewController.swift
//  CarrotHomeTab
//
//  Created by Yuhyeon Kim on 2023/01/19.
//


import UIKit
import Combine
import Kingfisher

class DetailViewController: UIViewController {
    
    //item
    @IBOutlet weak var itemThumbnail: UIImageView!
    @IBOutlet weak var itemInfoTitle: UILabel!
    @IBOutlet weak var itemInfoDescription: UILabel!
    //user
    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userTemperature: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var subscriptions = Set<AnyCancellable>()
    
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        bind()
        viewModel.fetch()
    }
    
    private func setupUI(){
        userThumbnail.layer.cornerRadius = 40
        userThumbnail.layer.masksToBounds = true
    }
    
    private func bind() {
        viewModel.$itemInfoDetails
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { details in
                self.itemThumbnail.kf.setImage(with: URL(string: details.item.thumbnailURL))
                self.itemInfoTitle.text = details.item.title
                self.itemInfoDescription.text = details.details.descriptions
                self.itemPriceLabel.text = "\(self.formatNumber(details.item.price))원"
                self.userThumbnail.kf.setImage(with: URL(string: details.user.thumnail))
                self.userNickName.text = details.user.name
                self.userLocation.text = details.user.location
                self.userTemperature.text = "\(details.user.temperature)°C"
            }.store(in: &subscriptions)
    }
    
    private func configureNavigationBar() {
        let moreConfig = CustomBarItemConfiguration(image: UIImage(systemName: "ellipsis"),handler: { print("--> more tapped") })
        let moreItem = UIBarButtonItem.generate(with: moreConfig, width: 30)
        
        let shareConfig = CustomBarItemConfiguration(image: UIImage(systemName: "square.and.arrow.up"),handler: { print("--> share tapped") })
        let shareItem = UIBarButtonItem.generate(with: shareConfig, width: 30)
        
        navigationItem.rightBarButtonItems = [moreItem, shareItem]
        navigationItem.backButtonDisplayMode = .minimal
    }
}

extension DetailViewController {
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        
        return result
    }
}
