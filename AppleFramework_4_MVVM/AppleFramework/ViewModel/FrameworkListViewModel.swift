//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by Yuhyeon Kim on 2023/01/04.
//

import Foundation
import Combine

final class FrameworkListViewModel {
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    // Data -> Output
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>
    
    // User Action -> Input
    func didSelect(at indexPath: IndexPath) {
        selectedItem.send(items.value[indexPath.item])
    }
}
