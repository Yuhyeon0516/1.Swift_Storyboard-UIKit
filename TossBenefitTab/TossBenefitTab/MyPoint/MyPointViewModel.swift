//
//  MyPointViewModel.swift
//  TossBenefitTab
//
//  Created by Yuhyeon Kim on 2023/01/12.
//

import Foundation

final class MyPointViewModel {
    @Published var point: MyPoint
    
    init(point: MyPoint) {
        self.point = point
    }
}
