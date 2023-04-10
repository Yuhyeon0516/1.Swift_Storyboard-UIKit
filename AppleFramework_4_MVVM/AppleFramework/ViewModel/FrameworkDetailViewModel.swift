//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by Yuhyeon Kim on 2023/01/04.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    // Data -> Output
    let framework: CurrentValueSubject<AppleFramework, Never>
    
    // User Action -> Ouput
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}
