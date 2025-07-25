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
}
