//
//  TodaySectionItem.swift
//  TossBenefitTab
//
//  Created by Yuhyeon Kim on 2023/01/08.
//

import Foundation

struct TodaySectionItem {
    var point: MyPoint
    var today: Benefit
    
    var sectionItems: [AnyHashable] {
        return [point,today]
    }
}

extension TodaySectionItem {
    static let mock = TodaySectionItem(point: MyPoint(point: 0), today: Benefit.walk)
}
