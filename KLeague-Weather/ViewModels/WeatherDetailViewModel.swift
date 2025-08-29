//
//  WeatherDetailViewModel.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import Foundation
import Combine

final class WeatherDetailViewModel {
    @Published var temperature: String = "--"
    @Published var humidity: String = "--"
    @Published var precipitation: String = "정보 없음" // 강수 형태
    
    @Published var errorMessage: String?
    
    private var weatherItems: [Item] = [] {
        didSet {
            processWeatherData()
        }
    }
    
    private let networkService: WeatherNetworkService
    private let team: Team
    
    init(networkService: WeatherNetworkService = .shared, team: Team) {
        self.networkService = networkService
        self.team = team
    }
    
    // MARK: - 날씨 관련 함수
    
    func fetchCurrentWeather() {
        let nx = team.nx
        let ny = team.ny
        
        networkService.fetchCurrentWeahter(nx: nx, ny: ny) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let items):
                    self.weatherItems = items
                    print("날씨 정보 수신 성공: \(items.count)개 항목")
                case .failure(let error):
                    self.errorMessage = self.mapErrorToMessage(error)
                    print("날씨 정보 수신 실패: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - 데이터 가공 함수
    private func processWeatherData() {
        for item in weatherItems {
            switch item.category {
            case "T1H": // 기온
                self.temperature = "\(item.obsrValue)°"
            case "REH": // 습도
                self.humidity = "\(item.obsrValue)%"
            case "PTY":
                self.precipitation = mapPrecipitationCode(item.obsrValue)
            default:
                break
            }
        }
    }
    
    private func mapPrecipitationCode(_ code: String) -> String {
        switch code {
        case "0": return "맑음"
        case "1": return "비"
        case "2": return "비/눈"
        case "3": return "눈"
        case "5": return "빗방울"
        case "6": return "빗방울/눈날림"
        case "7": return "눈날림"
        default: return "정보 없음"
        }
    }
    
    // MARK: - error 매핑 함수
    
    private func mapErrorToMessage(_ error: NetworkError) -> String {
        switch error {
        case .decodingError:
            return "데이터를 처리하는 중 오류가 발생했습니다."
        case .apiError(let message):
            return "API 오류: \(message)"
        default:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
    // MARK: - 팀이름, 경기장 이름 반환 함수
    func getTeamName() -> String {
        return team.name
    }
    
    func getStadiumName() -> String {
        return team.stadiumName
    }
}
