//
//  HourlyWeatherViewCell.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 8/19/25.
//

import UIKit
import SwiftUI
import SnapKit

final class HourlyWeatherCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HourlyWeatherCell"
    
    // MARK: - UI Components
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: Constants.Font.gmarketSansMedium, size: 14)
        timeLabel.textColor = .label
        return timeLabel
    }()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont(name: Constants.Font.gmarketSansBold, size: 18)
        temperatureLabel.textColor = .label
        return temperatureLabel
    }()
    
    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemBlue
        return iconImageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = Constants.UI.cornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func configure(with data: HourlyWeather) {
        timeLabel.text = data.time
        temperatureLabel.text = "\(data.temperature)°"
        iconImageView.image = UIImage(systemName: data.iconName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        temperatureLabel.text = nil
        iconImageView.image = nil
    }
}

// MARK: - 미리보기
#if DEBUG
struct HourlyWeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherCell().toPreview()
    }
}
#endif
