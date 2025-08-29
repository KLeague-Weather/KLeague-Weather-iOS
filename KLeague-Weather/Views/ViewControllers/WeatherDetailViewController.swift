//
//  WeatherDetailViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import UIKit
import SwiftUI
import SnapKit

// MARK: - Mock Data
private struct MockWeatherData {
    let currentTemperature: Int = 23
    let condition: String = "대체로 맑음"
    let highTemp: Int = 26
    let lowTemp: Int = 15
    let weatherIconName: String = "sun.max.fill" // SF Symbol
    
    static let hourly: [MockHourlyData] = [
        .init(time: "Now", icon: "sun.max.fill", temp: 23),
        .init(time: "15시", icon: "cloud.sun.fill", temp: 22),
        .init(time: "16시", icon: "cloud.fill", temp: 21),
        .init(time: "17시", icon: "cloud.fill", temp: 20),
        .init(time: "18시", icon: "cloud.sun.fill", temp: 19),
        .init(time: "19시", icon: "moon.fill", temp: 18),
        .init(time: "20시", icon: "moon.stars.fill", temp: 17)
    ]
    
    static let daily: [MockDailyData] = [
        .init(day: "오늘", icon: "sun.max.fill", high: 26, low: 15),
        .init(day: "금", icon: "cloud.sun.fill", high: 24, low: 16),
        .init(day: "토", icon: "cloud.rain.fill", high: 22, low: 14),
        .init(day: "일", icon: "cloud.heavyrain.fill", high: 21, low: 15),
        .init(day: "월", icon: "sun.max.fill", high: 25, low: 17),
        .init(day: "화", icon: "cloud.bolt.fill", high: 23, low: 16),
        .init(day: "수", icon: "wind", high: 24, low: 15)
    ]
}

private struct MockHourlyData {
    let time: String
    let icon: String
    let temp: Int
}

private struct MockDailyData {
    let day: String
    let icon: String
    let high: Int
    let low: Int
}


// MARK: - WeatherDetailViewController
import Combine

final class WeatherDetailViewController: UIViewController {
    
    private let viewModel: WeatherDetailViewModel
    private let mockData = MockWeatherData() // 임시 목업 데이터
    
    // Combine 구독을 관리하기 위한 Set
    private var cancellables = Set<AnyCancellable>()
    
    init(team: Team) {
        self.viewModel = WeatherDetailViewModel(team: team)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // --- 헤더 UI ---
    private lazy var stadiumNameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.getStadiumName()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 24)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "\(mockData.currentTemperature)°"
        label.font = UIFont.systemFont(ofSize: 80, weight: .thin)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = mockData.condition
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var highLowTempLabel: UILabel = {
        let label = UILabel()
        label.text = "\(mockData.highTemp)°  \(mockData.lowTemp)°"
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    // --- 시간별 예보 UI ---
    private let hourlyForecastContainer = UIView.createContainerView()
    private let hourlyTitleLabel = UILabel.createTitleLabel(with: "시간별 예보")
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 100)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    // --- 주간 예보 UI ---
    private let dailyForecastContainer = UIView.createContainerView()
    private let dailyTitleLabel = UILabel.createTitleLabel(with: "주간 예보")
    private lazy var dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: DailyForecastCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindViewModelForConsole() // ViewModel과 연동하여 콘솔에 출력
        
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = ""
    }
    
    // MARK: - ViewModel Binding for Console Output
    private func bindViewModelForConsole() {
        print("--- API 요청 시작: ViewModel과 바인딩 ---")

        viewModel.$temperature
            .dropFirst() // 초기값 "--"는 무시
            .sink { temp in
                print("✅ 온도 업데이트: \(temp)")
            }
            .store(in: &cancellables)

        viewModel.$humidity
            .dropFirst() // 초기값 "--"는 무시
            .sink { humidity in
                print("✅ 습도 업데이트: \(humidity)")
            }
            .store(in: &cancellables)

        viewModel.$precipitation
            .dropFirst() // 초기값 "정보 없음"은 무시
            .sink { precipitation in
                print("✅ 강수형태 업데이트: \(precipitation)")
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 } // nil이 아닌 에러 메시지만 받음
            .sink { errorMessage in
                print("❌ 에러 발생: \(errorMessage)")
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [stadiumNameLabel, temperatureLabel, conditionLabel, highLowTempLabel].forEach(contentView.addSubview)
        
        contentView.addSubview(hourlyForecastContainer)
        hourlyForecastContainer.addSubview(hourlyTitleLabel)
        hourlyForecastContainer.addSubview(hourlyCollectionView)
        
        contentView.addSubview(dailyForecastContainer)
        dailyForecastContainer.addSubview(dailyTitleLabel)
        dailyForecastContainer.addSubview(dailyTableView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        highLowTempLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        hourlyForecastContainer.snp.makeConstraints { make in
            make.top.equalTo(highLowTempLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        hourlyTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        hourlyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hourlyTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        let dailyCellHeight = 50
        let dailyRowCount = MockWeatherData.daily.count
        let dailyTableHeight = dailyCellHeight * dailyRowCount
        
        dailyForecastContainer.snp.makeConstraints { make in
            make.top.equalTo(hourlyForecastContainer.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        dailyTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        dailyTableView.snp.makeConstraints { make in
            make.top.equalTo(dailyTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(dailyTableHeight)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WeatherDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MockWeatherData.hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath) as? HourlyWeatherCell else {
            return UICollectionViewCell()
        }
        let data = MockWeatherData.hourly[indexPath.item]
        cell.configure(time: data.time, iconName: data.icon, temp: data.temp)
        return cell
    }
}

// MARK: - UITableViewDataSource
extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockWeatherData.daily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastCell.reuseIdentifier, for: indexPath) as? DailyForecastCell else {
            return UITableViewCell()
        }
        let data = MockWeatherData.daily[indexPath.row]
        cell.configure(day: data.day, iconName: data.icon, high: data.high, low: data.low)
        return cell
    }
}


// MARK: - Helper Extensions & Custom Cells

fileprivate extension UIView {
    static func createContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }
}

fileprivate extension UILabel {
    static func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 14)
        label.textColor = .secondaryLabel
        return label
    }
}

// MARK: - DailyForecastCell
fileprivate class DailyForecastCell: UITableViewCell {
    static let reuseIdentifier = "DailyForecastCell"
    
    private let dayLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let lowTempLabel = UILabel()
    private let highTempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        setupCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        dayLabel.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 18)
        dayLabel.textColor = .label
        
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.tintColor = .label
        
        lowTempLabel.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 18)
        lowTempLabel.textColor = .secondaryLabel
        lowTempLabel.textAlignment = .right
        
        highTempLabel.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 18)
        highTempLabel.textColor = .label
        highTempLabel.textAlignment = .right
        
        [dayLabel, weatherIcon, lowTempLabel, highTempLabel].forEach(contentView.addSubview)
    }
    
    private func setupCellConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(28)
        }
        
        highTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        lowTempLabel.snp.makeConstraints { make in
            make.trailing.equalTo(highTempLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
    }
    
    func configure(day: String, iconName: String, high: Int, low: Int) {
        dayLabel.text = day
        weatherIcon.image = UIImage(systemName: iconName)
        highTempLabel.text = "최고:\(high)°"
        lowTempLabel.text = "최저:\(low)°"
    }
}


// MARK: - Preview Provider
#if DEBUG
struct WeatherDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        let team = Team(id: 13, name: "수원삼성블루윙즈", league: .kLeague2, logoURL: "suwonsamsung_logo", stadiumName: "수원월드컵경기장", nx: "62", ny: "121")
        NavigationView {
            WeatherDetailViewController(team: team)
                .toPreview()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#endif
