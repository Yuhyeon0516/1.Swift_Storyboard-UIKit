//
//  MainTabBarViewController.swift
//  CarrotHomeTab
//
//  Created by Yuhyeon Kim on 2023/01/19.
//

// [✅] 탭이 눌릴떄마다 그에 맞는 네비게이션바를 구성
// [✅] 탭이 눌리는 것을 감지
// [✅] 감지 후 그 탭에 맞게 네비게이션바를 구성 업데이트


// [✅] 각 탭에 맞게 네비게이션바 아이템 구성하기
// [✅] 홈: 타이틀, 피드, 서치
// [✅] 동네 생활: 타이틀, 피드
// [✅] 내 근처: 타이틀
// [✅] 채팅: 타이틀, 피드
// [✅] 나의 당근: 타이틀, 설정

// [✅] 앱이 시작할떄, 네비게이션바 아이템 설정을 완료
// [✅] 네비게이션 바를

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavgationItem(vc: self.selectedViewController!)
    }
    
    private func updateNavgationItem(vc: UIViewController) {
        switch vc {
        case is HomeViewController:
            let titleConfig = CustomBarItemConfiguration(title: "정자동", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let searchConfig = CustomBarItemConfiguration(image: UIImage(systemName: "magnifyingglass"),handler: { print("--> search tapped") })
            let searchItem = UIBarButtonItem.generate(with: searchConfig, width: 30)
            
            let feedConfig = CustomBarItemConfiguration(image: UIImage(systemName: "bell"),handler: { print("--> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem, searchItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyTownViewController:
            let titleConfig = CustomBarItemConfiguration(title: "정자동", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(image: UIImage(systemName: "bell"),handler: { print("--> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is ChatViewController:
            let titleConfig = CustomBarItemConfiguration(title: "채팅", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(image: UIImage(systemName: "bell"),handler: { print("--> feed tapped") })
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfiguration(title: "나의 당근", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let settingConfig = CustomBarItemConfiguration(image: UIImage(systemName: "gearshape"),handler: { print("--> setting tapped") })
            let settingItem = UIBarButtonItem.generate(with: settingConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [settingItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        default:
            let titleConfig = CustomBarItemConfiguration(title: "정자동", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = []
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavgationItem(vc: viewController)
    }
}
