//
//  DetailViewModel.swift
//  CarrotHomeTab
//
//  Created by Yuhyeon Kim on 2023/01/22.
//

import Foundation

final class DetailViewModel {
    let network: NetworkService
    let itemInfo: ItemInfo
    
    @Published var itemInfoDetails: ItemInfoDetails? = nil
    
    init(network: NetworkService, itemInfo: ItemInfo) {
        self.network = network
        self.itemInfo = itemInfo
    }
    
    func fetch() {
        // simulate network like behavior
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.itemInfoDetails = ItemInfoDetails(user: User.mock, item: itemInfo, details: ItemExtraInfo.mock)
        }
    }
}
