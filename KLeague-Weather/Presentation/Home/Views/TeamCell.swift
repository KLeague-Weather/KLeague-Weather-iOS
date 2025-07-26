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
        label.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 14)
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(teamNameLabel)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - 구성
    func configure(with team: Team) {
        teamNameLabel.text = team.name
        logoImageView.image = UIImage(named: team.logoURL)
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
