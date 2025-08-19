//
//  WeatherDetailViewModel.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/29/25.
//

import Foundation

final class WeatherDetailViewModel {
    
    // MARK: - Properties
    private let team: Team
    private var weatherData: WeatherData?
    
    // MARK: - Initializer
    init(team: Team) {
        self.team = team
        loadWeatherData()
    }
    
    // MARK: - Public Methods
    func getTeam() -> Team {
        return team
    }
    
    func getCurrentWeather() -> CurrentWeather? {
        return weatherData?.currentWeather
    }
    
    func getHourlyWeather() -> [HourlyWeather] {
        return weatherData?.hourlyWeather ?? []
    }
    
    func getHourlyWeatherCount() -> Int {
        return weatherData?.hourlyWeather.count ?? 0
    }
    
    func getHourlyWeather(at index: Int) -> HourlyWeather? {
        guard let hourlyWeather = weatherData?.hourlyWeather,
              index >= 0 && index < hourlyWeather.count else { return nil }
        return hourlyWeather[index]
    }
    
    // MARK: - Private Methods
    private func loadWeatherData() {
        // Mock 데이터 로드 (나중에 API로 교체)
        weatherData = WeatherData.mockData(for: team)
    }
}
