//
//  Weather.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

// MARK: - 응답 모델
struct WeatherAPIResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let header: Header
    let body: Body
}

struct Header: Codable {
    let resultCode: String
    let resultMsg: String
}

struct WeatherItems: Codable {
    let item: [Item]
}

struct Body: Codable {
    let dataType: String
    let items: WeatherItems
}

struct Item: Codable {
    let baseDate: String
    let baseTime: String
    let category: String
    let nx: Int
    let ny: Int
    let obsrValue: String
}
