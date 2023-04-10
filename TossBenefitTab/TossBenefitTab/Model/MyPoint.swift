//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by Yuhyeon Kim on 2023/01/08.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
