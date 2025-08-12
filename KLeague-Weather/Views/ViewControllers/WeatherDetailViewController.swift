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
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBackground
        
        return contentView
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let teamNameLabel = UILabel()
        teamNameLabel.text = team.name
        teamNameLabel.font = UIFont(name: "GmarketSansMedium", size: 15)
        
        return teamNameLabel
    }()

    private lazy var stadiumNameLabel: UILabel = {
        let stadiumNameLabel = UILabel()
        stadiumNameLabel.text = team.stadiumName
        stadiumNameLabel.font = UIFont(name: "GmarketSansMedium", size: 23)
        
        return stadiumNameLabel
    }()
    
    // mock data
    private let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "32°"
        tempLabel.font = UIFont(name: "GmarketSansMedium", size: 70)
        
        return tempLabel
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
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(stadiumNameLabel)
        contentView.addSubview(tempLabel)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}

// MARK: - 미리보기
#if DEBUG
struct WeatherDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailViewController(team: Team(id: 13, name: "수원삼성블루윙즈", league: .kLeague2, logoURL: "suwonsamsung_logo", stadiumName: "수원월드컵경기장", nx: "62", ny: "121")).toPreview()
    }
}
#endif
