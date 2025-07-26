//
//  Constants.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation
import UIKit

struct Constants {
    // MARK: - 폰트 이름
    struct Font {
        static let gmarketSansBold = "GmarketSansBold"
        static let gmarketSansLight = "GmarketSansLight"
        static let gmarketSansMedium = "GmarketSansMedium"
    }
    
    // MARK: - UI 상수
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let cellSpacing: CGFloat = 16
        static let sectionInset: CGFloat = 16
    }
    
    // MARK: - Collection View
    struct CollectionView {
        static let itemsPerRow: CGFloat = 2
        static let cellHeight: CGFloat = 120
    }
    
    // MARK: - Weather
    struct Weather {
        static let iconSize: CGFloat = 120
        static let temperatureFontSize: CGFloat = 48
        static let descriptionFontSize: CGFloat = 18
    }
    
    // MARK: - API
    struct API {
        static let baseURL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0"
        static let serviceKey = "lgR40p%2FFDGZn7wPL%2FgLW%2FUdADdyweV8qY9PCqNWFkrt4Id5QvF71R5%2FewG3QIizH2yVxjLxrB0cJgnm5t%2BuWKQ%3D%3D"
        
        // API 파라미터
        static let pageNo = "1"
        static let numOfRows = "100"
        static let dataType = "JSON"
        
        // 단기예보 파라미터
        static let baseDate = getBaseDate()
        static let baseTime = getBaseTime()
        
        // 헬퍼 메서드
        private static func getBaseDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            return formatter.string(from: Date())
        }
        
        private static func getBaseTime() -> String {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            
            let now = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: now)
            
            // 단기예보는 02, 05, 08, 11, 14, 17, 20, 23시에 발표
            let baseHours = [2, 5, 8, 11, 14, 17, 20, 23]
            let currentBaseHour = baseHours.last { $0 <= hour } ?? 23
            
            return String(format: "%02d00", currentBaseHour)
        }
    }
}
