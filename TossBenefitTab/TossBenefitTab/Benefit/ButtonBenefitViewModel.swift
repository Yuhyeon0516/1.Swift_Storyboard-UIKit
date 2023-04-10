//
//  ButtonBenefitViewModel.swift
//  TossBenefitTab
//
//  Created by Yuhyeon Kim on 2023/01/12.
//

import Foundation

final class ButtonBenefitViewModel {
    @Published var benefit: Benefit
    @Published var benefitDetails: BenefitDetails?
    
    init(benefit: Benefit) {
        self.benefit = benefit
    }
    func fetchDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.benefitDetails = .default
        }
    }
}
