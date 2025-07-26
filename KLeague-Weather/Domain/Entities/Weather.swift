//
//  Weather.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

struct Weather {
    let temperature: Double
    let weatherDescription: String
    let humidity: Int
    let windSpeed: Double
    let feelsLike: Double
    let weatherIcon: String
    let weatherType: WeatherType
}

enum WeatherType: String, CaseIterable {
    case sunny = "01.sun-light"
    case sunset = "02.sunset-light"
    case sunrise = "03.sunrise-light"
    case eclipse = "04.eclipse-light"
    case partialCloudy = "05.partial-cloudy-light"
    case rainyDay = "06.rainyday-light"
    case mostlyCloud = "07.mostly-cloud-light"
    case fullMoon = "08.full-moon-light"
    case halfMoon = "09.half-moon-light"
    case cloudyNight = "10.cloudy-night-light"
    case mostlyCloudy = "11.mostly-cloudy-light"
    case thunder = "12.thunder-light"
    case thunderstorm = "13.thunderstorm-light"
    case heavySnowfall = "14.heavy-snowfall-light"
    case cloudLight = "15.cloud-light"
    case cloudyNightStars = "16.cloudy-night-stars-light"
    case heavyRain = "17.heavy-rain-light"
    case moonSet = "18.moon-set-light"
    case rain = "19.rain-light"
    case heavyWind = "20.heavy-wind-light"
    case snow = "21.snow-light"
    case hailstrom = "22.hailstrom-light"
    case drop = "23.drop-light"
}
