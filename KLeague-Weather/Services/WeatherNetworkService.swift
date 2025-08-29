//
//  WeatherNetworkService.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/28/25.
//

import Foundation
import SwiftUI
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case apiError(String)
    case unknown
}

class WeatherNetworkService {
    // 싱글톤 패턴
    static let shared = WeatherNetworkService()
    private init() {}
    
    // baseURL
    private let baseURL = "\(Constants.API.baseURL)/getUltraSrtNcst"
    
    // info.plist에서 ServiceKey 가져옴
    private var serviceKey: String? {
        return Bundle.main.object(forInfoDictionaryKey: "KMA_API_KEY") as? String
    }
    
    // MARK: - alamofire 통신 함수
    func fetchCurrentWeahter(nx: String, ny: String, completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        // ✅ 수정된 부분: serviceKey가 nil일 경우, .failure를 호출하고 종료
        guard let serviceKey = serviceKey else {
            completion(.failure(.apiError("Info.plist에 KMA_API_KEY가 없거나 잘못되었습니다.")))
            return
        }
        
        // baseDate, baseTime 계산 로직
        let (baseDate, baseTime) = calculateBaseDateAndTime()
        
        // params
        let params: [String: Any] = [
            "ServiceKey": serviceKey,
            "pageNo": 1,
            "numOfRows": 10,
            "dataType": "JSON",
            "base_date": baseDate,
            "base_time": baseTime,
            "nx": nx,
            "ny": ny
        ]
        
        // alamofire 요청
        AF.request(baseURL, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: WeatherAPIResponse.self) { response in
                switch response.result {
                case .success(let weatherResponse):
                    if weatherResponse.response.header.resultCode != "00" {
                        completion(.failure(.apiError(weatherResponse.response.header.resultMsg)))
                        return
                    }
                    let items = weatherResponse.response.body.items.item
                    completion(.success(items))
                case .failure(let error):
                    // ✅ 개선된 부분: 디코딩 실패 시 더 자세한 에러를 전달
                    print("디코딩 에러: \(error)")
                    completion(.failure(.decodingError))
                }
            }
    }
    
    // MARK: - baseDate, baseTime 계산 함수
    private func calculateBaseDateAndTime() -> (baseDate: String, baseTime: String) {
        var now = Date()
        let calendar = Calendar.current
        
        if calendar.component(.minute, from: now) < 45 {
            now = calendar.date(byAdding: .hour, value: -1, to: now) ?? Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let baseDate = dateFormatter.string(from: now)
        
        dateFormatter.dateFormat = "HH00"
        let baseTime = dateFormatter.string(from: now)
        
        return (baseDate, baseTime)
    }
}
