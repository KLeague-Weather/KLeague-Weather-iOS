//
//  WeatherResponse.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

// MARK: - 기상청 API 응답 모델
struct WeatherResponse: Codable {
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

struct Body: Codable {
    let items: Items
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct Items: Codable {
    let item: [WeatherItem]
}

// MARK: - 단기예보 아이템 (Long-Format)
struct WeatherItem: Codable {
    let baseDate: String? // 발표일자
    let baseTime: String? // 발표시각
    let category: String? // 자료구분문자
    let fcstDate: String? // 예보일자
    let fcstTime: String? // 예보시각
    let fcstValue: String? // 예보값
    let nx: String? // 예보지점 X 좌표
    let ny: String? // 예보지점 Y 좌표
    
    enum CodingKeys: String, CodingKey {
        case baseDate = "baseDate"
        case baseTime = "baseTime"
        case category = "category"
        case fcstDate = "fcstDate"
        case fcstTime = "fcstTime"
        case fcstValue = "fcstValue"
        case nx = "nx"
        case ny = "ny"
    }
}

// MARK: - 시간별 예보 모델 (최종 목표 DTO)
struct HourlyForecast {
    let forecastTime: String // "1500", "1600" 등 예보 시각
    
    var temperature: String?
    var skyCondition: String? // 하늘 상태 코드 (ex: "1")
    var precipitationType: String? // 강수 형태 코드 (ex: "0")
    var humidity: String?
    var precipitationProbability: String? // 강수 확률
    var windSpeed: String? // 풍속
    var precipitationAmount: String? // 1시간 강수량
    var snowfallAmount: String? // 1시간 신적설
    
    init(forecastTime: String) {
        self.forecastTime = forecastTime
    }
}

// MARK: - 초단기실황 아이템
struct UltraSrtNcstItem: Codable {
    let baseDate: String? // 발표일자
    let baseTime: String? // 발표시각
    let category: String? // 자료구분코드
    let obsrValue: String? // 실황값
    let nx: String? // 예보지점 X 좌표
    let ny: String? // 예보지점 Y 좌표
    
    enum CodingKeys: String, CodingKey {
        case baseDate = "baseDate"
        case baseTime = "baseTime"
        case category = "category"
        case obsrValue = "obsrValue"
        case nx = "nx"
        case ny = "ny"
    }
}

// MARK: - 초단기예보 아이템
struct UltraSrtFcstItem: Codable {
    let baseDate: String? // 발표일자
    let baseTime: String? // 발표시각
    let category: String? // 자료구분코드
    let fcstDate: String? // 예보일자
    let fcstTime: String? // 예보시각
    let fcstValue: String? // 예보값
    let nx: String? // 예보지점 X 좌표
    let ny: String? // 예보지점 Y 좌표
    
    enum CodingKeys: String, CodingKey {
        case baseDate = "baseDate"
        case baseTime = "baseTime"
        case category = "category"
        case fcstDate = "fcstDate"
        case fcstTime = "fcstTime"
        case fcstValue = "fcstValue"
        case nx = "nx"
        case ny = "ny"
    }
} 
