//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by 김유현 on 2022/12/30.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
//    @Published var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    var subscriptions = Set<AnyCancellable>()
    let framework = CurrentValueSubject<AppleFramework, Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // input : 버튼 동작 받기
        buttonTapped
            .compactMap { URL(string: $0.urlString) }
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions)

        // output : 섬네일, 타이틀, 디스크립션 ui update
        framework
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
    }
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        buttonTapped.send(framework.value)
    }
}
