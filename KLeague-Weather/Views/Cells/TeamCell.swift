//
//  TeamCell.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import UIKit
import SnapKit
import SwiftUI

class TeamCell: UICollectionViewCell {
    
    // MARK: - UI 컴포넌트
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.UI.cornerRadius
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansBold, size: 18)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let teamStadiumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 13)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 설정
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = Constants.UI.cornerRadius
        
        // 다크모드 지원을 위한 테두리와 그림자 설정
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor
        
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.15
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(teamStadiumNameLabel)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        teamStadiumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - 구성
    func configure(with team: Team) {
        logoImageView.image = UIImage(named: team.logoURL)
        teamNameLabel.text = team.name
        teamStadiumNameLabel.text = team.stadiumName
    }
    
    // MARK: - 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        teamNameLabel.text = nil
    }
}

// MARK: - 미리보기
#if DEBUG
struct TeamCell_Previews: PreviewProvider {
    static var previews : some View {
        TeamCell().toPreview()
    }
}
#endif
