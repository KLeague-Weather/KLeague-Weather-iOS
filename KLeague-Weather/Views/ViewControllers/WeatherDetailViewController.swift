//
//  WeatherDetailViewController.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import UIKit
import SwiftUI
import SnapKit

final class WeatherDetailViewController: UIViewController {
    // MARK: - 팀 데이터
    private let team: Team
    
    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 컴포넌트
    
    // 컨텐트 뷰
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        
        return contentView
    }()

    // 경기장 이름
    private lazy var stadiumNameLabel: UILabel = {
        let stadiumNameLabel = UILabel()
        stadiumNameLabel.text = team.stadiumName
        stadiumNameLabel.font = UIFont(name: "GmarketSansMedium", size: 23)
        
        return stadiumNameLabel
    }()
    
    // 온도 레이블
    private let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "32°"
        tempLabel.font = UIFont(name: "GmarketSansMedium", size: 70)
        
        return tempLabel
    }()
    
    // 직관 컨디션 레이블
    private let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.text = "직관하기 힘든 날씨에요,,"
        conditionLabel.font = UIFont(name: "GmarketSansBold", size: 18)
        
        return conditionLabel
    }()
    
    // 직관 조언 레이블
    private let adviceLabel: UILabel = {
        let adviceLabel = UILabel()
        adviceLabel.text = "수분을 충분히 섭취해주세요!"
        adviceLabel.font = UIFont(name: "GmarketSansBold", size: 18)
        
        return adviceLabel
    }()
    
    // 팀 로고 이미지뷰
    private lazy var teamLogoImageView: UIImageView = {
        let teamLogoImageView = UIImageView()
        teamLogoImageView.contentMode = .scaleAspectFit
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.layer.cornerRadius = Constants.UI.cornerRadius
        teamLogoImageView.image = UIImage(named: team.logoURL)
        teamLogoImageView.alpha = 0.2
        
        return teamLogoImageView
    }()
    
    // 날씨 로고 이미지 뷰
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.clipsToBounds = true
        weatherImageView.layer.cornerRadius = Constants.UI.cornerRadius
        
        if let weatherImage = UIImage(systemName: "sun.max") {
            weatherImageView.image = weatherImage
            weatherImageView.tintColor = .systemYellow
        }
        
        return weatherImageView
    }()
    
    // MARK: - app lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    // MARK: - setting
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(contentView)
//        contentView.addSubview(teamNameLabel)
        contentView.addSubview(stadiumNameLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(adviceLabel)
        contentView.addSubview(teamLogoImageView)
        contentView.addSubview(weatherImageView)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(30)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }
        
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
        }
        
        teamLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(450)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(80)
            make.width.height.equalTo(400)
        }
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
