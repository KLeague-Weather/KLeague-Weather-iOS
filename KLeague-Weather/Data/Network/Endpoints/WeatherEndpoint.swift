//
//  WeatherEndpoint.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

struct WeatherEndpoint {
    
    // MARK: - 단기예보 API 엔드포인트
    static func getVilageFcst(nx: String, ny: String) -> URL? {
        var components = URLComponents(string: "\(Constants.API.baseURL)/getVilageFcst")
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.API.serviceKey),
            URLQueryItem(name: "pageNo", value: Constants.API.pageNo),
            URLQueryItem(name: "numOfRows", value: Constants.API.numOfRows),
            URLQueryItem(name: "dataType", value: Constants.API.dataType),
            URLQueryItem(name: "base_date", value: Constants.API.baseDate),
            URLQueryItem(name: "base_time", value: Constants.API.baseTime),
            URLQueryItem(name: "nx", value: String(nx)),
            URLQueryItem(name: "ny", value: String(ny))
        ]
        return components?.url
    }
    
    // MARK: - 초단기실황 API 엔드포인트
    static func getUltraSrtNcst(nx: Int, ny: Int) -> URL? {
        var components = URLComponents(string: "\(Constants.API.baseURL)/getUltraSrtNcst")
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.API.serviceKey),
            URLQueryItem(name: "pageNo", value: Constants.API.pageNo),
            URLQueryItem(name: "numOfRows", value: Constants.API.numOfRows),
            URLQueryItem(name: "dataType", value: Constants.API.dataType),
            URLQueryItem(name: "base_date", value: Constants.API.baseDate),
            URLQueryItem(name: "base_time", value: Constants.API.baseTime),
            URLQueryItem(name: "nx", value: String(nx)),
            URLQueryItem(name: "ny", value: String(ny))
        ]
        return components?.url
    }
    
    // MARK: - 초단기예보 API 엔드포인트
    static func getUltraSrtFcst(nx: Int, ny: Int) -> URL? {
        var components = URLComponents(string: "\(Constants.API.baseURL)/getUltraSrtFcst")
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.API.serviceKey),
            URLQueryItem(name: "pageNo", value: Constants.API.pageNo),
            URLQueryItem(name: "numOfRows", value: Constants.API.numOfRows),
            URLQueryItem(name: "dataType", value: Constants.API.dataType),
            URLQueryItem(name: "base_date", value: Constants.API.baseDate),
            URLQueryItem(name: "base_time", value: Constants.API.baseTime),
            URLQueryItem(name: "nx", value: String(nx)),
            URLQueryItem(name: "ny", value: String(ny))
        ]
        return components?.url
    }
}
