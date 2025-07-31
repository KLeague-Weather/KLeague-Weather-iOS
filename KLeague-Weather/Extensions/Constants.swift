//
//  Constants.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import UIKit

struct Constants {
    
    // MARK: - Font
    struct Font {
        static let gmarketSansLight = "GmarketSansLight"
        static let gmarketSansMedium = "GmarketSansMedium"
        static let gmarketSansBold = "GmarketSansBold"
    }
    
    // MARK: - UI
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let cellSpacing: CGFloat = 12
        static let sectionInset: CGFloat = 16
    }
    
    // MARK: - CollectionView
    struct CollectionView {
        static let itemsPerRow: CGFloat = 2
        static let cellHeight: CGFloat = 160
    }
    
    // MARK: - API
    struct API {
        static let baseURL = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0"
        static let serviceKey = "lgR40p%2FFDGZn7wPL%2FgLW%2FUdADdyweV8qY9PCqNWFkrt4Id5QvF71R5%2FewG3QIizH2yVxjLxrB0cJgnm5t%2BuWKQ%3D%3D"
    }
} 
