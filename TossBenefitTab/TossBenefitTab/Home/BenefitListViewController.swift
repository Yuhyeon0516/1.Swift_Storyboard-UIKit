//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by Yuhyeon Kim on 2023/01/08.
//
//- 사용자는 포인트를 볼 수 있다.
//- 사용자는 오늘의 혜택을 볼 수 있다.
//- 사용자는 나머지 혜택 리스트를 볼 수 있다.
//- 사용자는 포인트 셀을 눌렀을때 포인트 상세뷰로 이동한다.
//- 사용자는 혜택관련 셀을 눌렀을때 혜택 상세뷰로 이동한다.

import UIKit
import Combine

class BenefitListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    
    enum Section: Int {
        case today
        case other
    }
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    let viewModel: BenefitListViewModel = BenefitListViewModel()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureCollectionView()
        bind()
        viewModel.fetchItems()
    }
    
    private func setupUI() {
        navigationItem.title = "혜택"
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: section, item: item, indexPath: indexPath,collectionView: collectionView)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func bind() {
        //Output
        viewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: .today)
            }.store(in: &subscriptions)
        
        viewModel.$otherSectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: .other)
            }.store(in: &subscriptions)
        
        //Input
        viewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink { benefit in
                let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
                vc.viewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { point in
                let sb = UIStoryboard(name: "MyPoint", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
                vc.viewModel = MyPointViewModel(point: point)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func applySnapshot(items: [Item], section: Section) {
        var snapshot = datasource.snapshot()
        snapshot.appendItems(items, toSection: section)
        datasource.apply(snapshot)
    }
    
    private func configureCell(for section: Section, item: Item, indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell? {
        switch section {
        case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("---> \(item)")
        
        if let benefit = item as? Benefit {
            viewModel.benefitDidTapped.send(benefit)
        } else if let point = item as? MyPoint {
            viewModel.pointDidTapped.send(point)
        } else {
            // no operation
        }
    }
}
