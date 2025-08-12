//
//  HomeViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import UIKit
import SnapKit
import SwiftUI

final class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    
    // MARK: - UI 컴포넌트 즉시 실행 클로저 패턴으로 구현
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGroupedBackground
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: League.allCases.map { $0.rawValue })
        control.selectedSegmentIndex = 0
        control.backgroundColor = .systemBackground
        control.selectedSegmentTintColor = .label
        
        // Gmarket 폰트 설정
        let normalFont = UIFont(name: Constants.Font.gmarketSansMedium, size: 16)
        let selectedFont = UIFont(name: Constants.Font.gmarketSansBold, size: 16)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.label,
            .font: normalFont ?? UIFont.systemFont(ofSize: 16)
        ], for: .normal)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.systemBackground,
            .font: selectedFont ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        return control
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.UI.cellSpacing
        layout.minimumInteritemSpacing = Constants.UI.cellSpacing
        layout.sectionInset = UIEdgeInsets(
            top: Constants.UI.sectionInset,
            left: Constants.UI.sectionInset,
            bottom: Constants.UI.sectionInset,
            right: Constants.UI.sectionInset
        )
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: "TeamCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false // 스크롤뷰가 스크롤을 담당
        return collectionView
    }()
    
    // MARK: - app lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    // MARK: - setting
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        // 네비게이션 타이틀 숨기기
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        title = ""
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(calculateTotalContentHeight())
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(calculateCollectionViewHeight())
        }
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        let itemCount = viewModel.getFilteredTeamsCount()
        let rows = ceil(Double(itemCount) / Double(Constants.CollectionView.itemsPerRow))
        let itemHeight = Constants.CollectionView.cellHeight
        let spacing = Constants.UI.cellSpacing
        let sectionInset = Constants.UI.sectionInset * 2
        
        let totalHeight = CGFloat(rows) * itemHeight + CGFloat(max(0, rows - 1)) * spacing + sectionInset
        
        // 최소 높이 보장
        return max(totalHeight, 400)
    }
    
    private func calculateTotalContentHeight() -> CGFloat {
        let titleLabelHeight: CGFloat = 32
        let titleLabelTopMargin: CGFloat = 16
        let titleLabelBottomMargin: CGFloat = 16
        let segmentedControlHeight: CGFloat = 32
        let segmentedControlBottomMargin: CGFloat = 16
        let bottomMargin: CGFloat = 16
        
        return titleLabelHeight + titleLabelTopMargin + titleLabelBottomMargin +
        segmentedControlHeight + segmentedControlBottomMargin +
        calculateCollectionViewHeight() + bottomMargin
    }
    
    private func updateCollectionViewHeight() {
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(calculateCollectionViewHeight())
        }
        
        // 스크롤뷰의 contentSize 업데이트
        contentView.snp.updateConstraints { make in
            make.height.equalTo(calculateTotalContentHeight())
        }
    }
    
    private func setupActions() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    // MARK: - 액션
    @objc private func segmentedControlChanged() {
        let selectedLeague = League.allCases[segmentedControl.selectedSegmentIndex]
        viewModel.selectLeague(selectedLeague)
        collectionView.reloadData()
        
        // 컬렉션 뷰 높이 업데이트
        updateCollectionViewHeight()
        
        // 애니메이션과 함께 레이아웃 업데이트
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFilteredTeamsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? TeamCell,
              let team = viewModel.getTeam(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: team)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 선택 효과 제거
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // 선택된 팀 가져오기
        guard let selectedTeam = viewModel.getTeam(at: indexPath.item) else { return }
        
        // 다음 화면 초기화(WeatherDetailViewController)
        let weatherDetailVC = WeatherDetailViewController(team: selectedTeam)
        
        // 네비게이션 컨트롤러를 사용해서 화면 전환
        navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Constants.UI.sectionInset * 2
        let spacing = Constants.UI.cellSpacing
        let availableWidth = collectionView.bounds.width - padding - spacing
        let itemWidth = availableWidth / Constants.CollectionView.itemsPerRow
        
        return CGSize(width: itemWidth, height: Constants.CollectionView.cellHeight)
    }
}

// MARK: - 미리보기
#if DEBUG
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
#endif
