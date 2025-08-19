//
//  Weather.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

enum WeatherType: String, CaseIterable {
    case sunny = "sunny"
    case clearCloudy = "clear-cloudy"
    case cloudy = "cloudy"
    case mostlyCloudy = "mostly-cloudy"
    case partlyCloudy = "partly-cloudy"
    case drizzle = "drizzle"
    case showers = "showers"
    case thunderstroms = "thunderstroms"
    case isolatedThunderstroms = "isolated-thunderstroms"
    case snow = "snow"
    case snowFlurries = "snow-flurries"
    case sleet = "sleet"
    case hail = "hail"
    case foggy = "foggy"
    case windy = "windy"
    case tornado = "tornado"
    case hot = "hot"
    case cold = "cold"
    
    var iconName: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .clearCloudy, .cloudy, .mostlyCloudy, .partlyCloudy:
            return "cloud.fill"
        case .drizzle, .showers:
            return "cloud.drizzle.fill"
        case .thunderstroms, .isolatedThunderstroms:
            return "cloud.bolt.fill"
        case .snow, .snowFlurries:
            return "cloud.snow.fill"
        case .sleet:
            return "cloud.sleet.fill"
        case .hail:
            return "cloud.hail.fill"
        case .foggy:
            return "cloud.fog.fill"
        case .windy:
            return "wind"
        case .tornado:
            return "tornado"
        case .hot:
            return "thermometer.sun.fill"
        case .cold:
            return "thermometer.snowflake"
        }
    }
}

// MARK: - Weather Models
struct WeatherData {
    let currentWeather: CurrentWeather
    let hourlyWeather: [HourlyWeather]
}

struct CurrentWeather {
    let temperature: Int
    let condition: String
    let advice: String
    let weatherType: WeatherType
}

struct HourlyWeather {
    let time: String
    let temperature: Int
    let weatherType: WeatherType
    
    var iconName: String {
        return weatherType.iconName
    }
}

// MARK: - Mock Data
extension WeatherData {
    static func mockData(for team: Team) -> WeatherData {
        let currentWeather = CurrentWeather(
            temperature: Int.random(in: 15...35),
            condition: "직관하기 좋은 날씨에요!",
            advice: "가벼운 겉옷을 챙기세요",
            weatherType: WeatherType.allCases.randomElement() ?? .sunny
        )
        
        let hourlyWeather = (0..<24).map { hour in
            HourlyWeather(
                time: String(format: "%02d:00", hour),
                temperature: Int.random(in: 10...40),
                weatherType: WeatherType.allCases.randomElement() ?? .sunny
            )
        }
        
        return WeatherData(currentWeather: currentWeather, hourlyWeather: hourlyWeather)
    }
}
