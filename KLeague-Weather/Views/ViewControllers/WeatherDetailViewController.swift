//
//  WeatherDetailViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import UIKit
import SnapKit
import SwiftUI

class WeatherDetailViewController: UIViewController {
    
    // MARK: - 프로퍼티
    private let viewModel: WeatherDetailViewModel
    
    // MARK: - UI 컴포넌트
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let stadiumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 24)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 48)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 16)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = Constants.UI.cornerRadius
        return stackView
    }()
    
    private let humidityView = WeatherDetailItemView(title: "습도", icon: "humidity")
    private let windSpeedView = WeatherDetailItemView(title: "풍속", icon: "wind")
    
    // MARK: - 초기화
    init(team: Team) {
        self.viewModel = WeatherDetailViewModel(team: team)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithTeam()
        loadWeatherData()
    }
    
    // MARK: - 설정
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = viewModel.teamName
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stadiumNameLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(humidityView)
        detailsStackView.addArrangedSubview(windSpeedView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIconImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    // MARK: - 구성
    private func configureWithTeam() {
        stadiumNameLabel.text = viewModel.stadiumName
    }
    
    private func loadWeatherData() {
        Task {
            // 실제 API 호출
            await viewModel.fetchWeather()
            await updateUI()
        }
    }
    
    @MainActor
    private func updateUI() async {
        guard let weather = viewModel.currentWeather else { return }
        
        // 날씨 이미지 설정 (Assets 사용)
        weatherIconImageView.image = UIImage(named: weather.weatherType.rawValue)
        
        // 기온 표시
        temperatureLabel.text = "\(Int(weather.temperature))°"
        
        // 날씨 설명
        weatherDescriptionLabel.text = weather.weatherDescription
        
        // 체감온도
        feelsLikeLabel.text = "체감 \(Int(weather.feelsLike))°"
        
        // 상세 정보 업데이트
        humidityView.configure(value: "\(weather.humidity)%")
        windSpeedView.configure(value: "\(weather.windSpeed)m/s")
    }
}

// MARK: - 날씨 상세 아이템 뷰
class WeatherDetailItemView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    init(title: String, icon: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: icon)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(value: String) {
        valueLabel.text = value
    }
}

// MARK: - 미리보기
#if DEBUG
struct WeatherDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailViewController(team: TeamData.allTeams[0]).toPreview()
    }
}
#endif
