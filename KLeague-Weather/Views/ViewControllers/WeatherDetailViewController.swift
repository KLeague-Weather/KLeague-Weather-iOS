//
//  WeatherDetailViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import UIKit
import SwiftUI
import SnapKit

final class WeatherDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    private let viewModel: WeatherDetailViewModel
    
    // MARK: - Initializer
    init(team: Team) {
        self.viewModel = WeatherDetailViewModel(team: team)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGroupedBackground
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    // 팀 로고 이미지뷰
    private lazy var teamLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.UI.cornerRadius
        imageView.image = UIImage(named: viewModel.getTeam().logoURL)
        return imageView
    }()
    
    // 경기장 이름
    private lazy var stadiumNameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.getTeam().stadiumName
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    // 날씨 아이콘
    private lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    // 온도 레이블
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 72)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    // 컨디션 레이블
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // 조언 레이블
    private lazy var adviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // 시간별 날씨 섹션 제목
    private let hourlySectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간별 날씨"
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 18)
        label.textColor = .label
        return label
    }()
    
    // 시간별 날씨 컬렉션뷰
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupSwipeGesture()
        updateWeatherData()
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(teamLogoImageView)
        contentView.addSubview(stadiumNameLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(adviceLabel)
        contentView.addSubview(hourlySectionTitleLabel)
        contentView.addSubview(hourlyCollectionView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        teamLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLogoImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIconImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        hourlySectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(adviceLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hourlySectionTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func updateWeatherData() {
        guard let currentWeather = viewModel.getCurrentWeather() else { return }
        
        temperatureLabel.text = "\(currentWeather.temperature)°"
        conditionLabel.text = currentWeather.condition
        adviceLabel.text = currentWeather.advice
        
        // SF Symbols 사용
        let iconName = currentWeather.weatherType.iconName
        weatherIconImageView.image = UIImage(systemName: iconName)
        
        // 온도에 따른 아이콘 색상 변경
        switch currentWeather.temperature {
        case 30...:
            weatherIconImageView.tintColor = .systemRed
        case 25...29:
            weatherIconImageView.tintColor = .systemOrange
        case 20...24:
            weatherIconImageView.tintColor = .systemYellow
        case 15...19:
            weatherIconImageView.tintColor = .systemBlue
        default:
            weatherIconImageView.tintColor = .systemCyan
        }
    }
    
    private func setupSwipeGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .ended, .cancelled:
            let shouldPop = translation.x > Constants.Gesture.swipeBackMinimumDistance ||
                           velocity.x > Constants.Gesture.swipeBackVelocityThreshold
            
            if shouldPop {
                navigationController?.popViewController(animated: true)
            }
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WeatherDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHourlyWeatherCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath) as? HourlyWeatherCell,
              let hourlyWeather = viewModel.getHourlyWeather(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: hourlyWeather)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}

// MARK: - 미리보기
#if DEBUG
struct WeatherDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailViewController(team: Team(id: 13, name: "수원삼성블루윙즈", league: .kLeague2, logoURL: "suwonsamsung_logo", stadiumName: "수원월드컵경기장", teamColor: "suwonsamsung_color", nx: "62", ny: "121")).toPreview()
    }
}
#endif
