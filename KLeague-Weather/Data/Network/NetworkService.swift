//
//  NetworkService.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

class NetworkService {
    
    // MARK: - 싱글톤
    static let shared = NetworkService()
    private init() {}
    
    // MARK: - URLSession 설정
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()
    
    // MARK: - 단기예보 데이터 가져오기
    func fetchWeatherData(nx: String, ny: String) async throws -> WeatherResponse {
        guard let url = WeatherEndpoint.getVilageFcst(nx: nx, ny: ny) else {
            throw NetworkError.invalidURL
        }
        
        print("🌤️ API 호출 URL: \(url)")
        print("📋 요청 파라미터:")
        print("   - serviceKey: \(Constants.API.serviceKey)")
        print("   - pageNo: \(Constants.API.pageNo)")
        print("   - numOfRows: \(Constants.API.numOfRows)")
        print("   - dataType: \(Constants.API.dataType)")
        print("   - base_date: \(Constants.API.baseDate)")
        print("   - base_time: \(Constants.API.baseTime)")
        print("   - nx: \(nx)")
        print("   - ny: \(ny)")
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        print("📡 HTTP 상태 코드: \(httpResponse.statusCode)")
        
        if httpResponse.statusCode != 200 {
            print("❌ API 에러 응답: \(String(data: data, encoding: .utf8) ?? "Unknown")")
            throw NetworkError.invalidResponse
        }
        
        // 응답 데이터 로깅
        if let responseString = String(data: data, encoding: .utf8) {
            print("📦 API 응답 데이터: \(responseString)")
        }
        
        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            print("✅ API 응답 파싱 성공: \(weatherResponse.response.body.items.item.count)개 아이템")
            return weatherResponse
        } catch {
            print("❌ JSON 파싱 에러: \(error)")
            throw NetworkError.decodingError
        }
    }
}

// MARK: - 네트워크 에러
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다."
        case .decodingError:
            return "데이터 파싱에 실패했습니다."
        }
    }
}
