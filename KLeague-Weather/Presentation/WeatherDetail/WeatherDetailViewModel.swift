//
//  WeatherDetailViewModel.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

class WeatherDetailViewModel {
    // MARK: - 프로퍼티
    private var team: Team
    private var weather: Weather?
    
    // MARK: - 계산 프로퍼티
    var teamName: String {
        return team.name
    }
    
    var stadiumName: String {
        return team.stadiumName
    }
    
    var teamLogoURL: String {
        return team.logoURL
    }
    
    var currentWeather: Weather? {
        return weather
    }
    
    // MARK: - 초기화
    init(team: Team) {
        self.team = team
    }
    
    // MARK: - 날씨 호출 메서드
    func fetchWeather() async {
        do {
            // 실제 API 호출
            let weatherResponse = try await NetworkService.shared.fetchWeatherData(
                nx: team.nx,
                ny: team.ny
            )
            
            // API 응답을 Weather 모델로 변환
            let weatherItems = weatherResponse.response.body.items.item
            if !weatherItems.isEmpty {
                let weather = convertToWeather(from: weatherItems)
                await MainActor.run {
                    self.weather = weather
                }
            } else {
                // API 데이터가 없으면 Mock 데이터 사용
                await loadMockWeather()
            }
        } catch {
            print("날씨 데이터 가져오기 실패: \(error)")
            // 에러 발생 시 Mock 데이터 사용
            await loadMockWeather()
        }
    }
    
    // MARK: - API 응답을 Weather 모델로 변환
    private func convertToWeather(from weatherItems: [WeatherItem]) -> Weather {
        print("🔄 \(weatherItems.count)개의 날씨 아이템을 파싱 중...")
        
        // 시간별 예보로 그룹핑
        let hourlyForecasts = parseHourlyForecasts(from: weatherItems)
        
        // 첫 번째 시간대의 데이터를 사용 (현재 시간에 가장 가까운)
        guard let currentForecast = hourlyForecasts.first else {
            print("⚠️ 시간별 예보 데이터가 없음")
            return createDefaultWeather()
        }
        
        print("📊 현재 예보: \(currentForecast.forecastTime)시 - 기온: \(currentForecast.temperature ?? "N/A")°C")
        
        let temperature = Double(currentForecast.temperature ?? "0") ?? 0.0
        let weatherDescription = getWeatherDescription(from: currentForecast.skyCondition ?? "1")
        let humidity = Int(currentForecast.humidity ?? "65") ?? 65
        let windSpeed = Double(currentForecast.windSpeed ?? "3.2") ?? 3.2
        
        let weatherType = getWeatherType(from: weatherDescription)
        
        return Weather(
            temperature: temperature,
            weatherDescription: weatherDescription,
            humidity: humidity,
            windSpeed: windSpeed,
            feelsLike: temperature + 2.0, // 체감온도 계산
            weatherIcon: "sun.max.fill",
            weatherType: weatherType
        )
    }
    
    // MARK: - 시간별 예보 파싱
    private func parseHourlyForecasts(from weatherItems: [WeatherItem]) -> [HourlyForecast] {
        var forecastDict: [String: HourlyForecast] = [:]
        
        for item in weatherItems {
            guard let fcstTime = item.fcstTime,
                  let category = item.category,
                  let fcstValue = item.fcstValue else { continue }
            
            // 해당 시간대의 예보 객체가 없으면 생성
            if forecastDict[fcstTime] == nil {
                forecastDict[fcstTime] = HourlyForecast(forecastTime: fcstTime)
            }
            
            // 카테고리별로 데이터 매핑
            switch category {
            case "TMP": // 1시간 기온
                forecastDict[fcstTime]?.temperature = fcstValue
            case "SKY": // 하늘 상태
                forecastDict[fcstTime]?.skyCondition = fcstValue
            case "PTY": // 강수 형태
                forecastDict[fcstTime]?.precipitationType = fcstValue
            case "POP": // 강수 확률
                forecastDict[fcstTime]?.precipitationProbability = fcstValue
            case "REH": // 습도
                forecastDict[fcstTime]?.humidity = fcstValue
            case "WSD": // 풍속
                forecastDict[fcstTime]?.windSpeed = fcstValue
            case "PCP": // 1시간 강수량
                forecastDict[fcstTime]?.precipitationAmount = fcstValue
            case "SNO": // 1시간 신적설
                forecastDict[fcstTime]?.snowfallAmount = fcstValue
            default:
                break
            }
        }
        
        // 시간순으로 정렬
        let sortedForecasts = forecastDict.values.sorted { $0.forecastTime < $1.forecastTime }
        print("⏰ \(sortedForecasts.count)개 시간대의 예보 데이터 생성 완료")
        
        return sortedForecasts
    }
    
    // MARK: - 기본 날씨 생성
    private func createDefaultWeather() -> Weather {
        return Weather(
            temperature: 22.0,
            weatherDescription: "맑음",
            humidity: 65,
            windSpeed: 3.2,
            feelsLike: 24.0,
            weatherIcon: "sun.max.fill",
            weatherType: .sunny
        )
    }
    
    // MARK: - 하늘상태 코드를 날씨 설명으로 변환
    private func getWeatherDescription(from skyCode: String) -> String {
        switch skyCode {
        case "1":
            return "맑음"
        case "3":
            return "구름많음"
        case "4":
            return "흐림"
        default:
            return "맑음"
        }
    }
    
    // MARK: - 날씨 설명을 WeatherType으로 변환
    private func getWeatherType(from description: String) -> WeatherType {
        switch description {
        case "맑음":
            return .sunny
        case "구름많음", "흐림":
            return .mostlyCloud
        case "비":
            return .rain
        case "눈":
            return .snow
        case "천둥번개":
            return .thunder
        default:
            return .sunny
        }
    }
    
    // MARK: - 테스트 메서드 (다양한 날씨 타입 테스트용)
    func loadRandomWeather() async {
        let randomWeatherType = WeatherType.allCases.randomElement() ?? .sunny
        let mockWeather = Weather(
            temperature: Double.random(in: 15...30),
            weatherDescription: getWeatherDescription(for: randomWeatherType),
            humidity: Int.random(in: 40...90),
            windSpeed: Double.random(in: 0...10),
            feelsLike: Double.random(in: 15...30),
            weatherIcon: "sun.max.fill",
            weatherType: randomWeatherType
        )
        
        await MainActor.run {
            self.weather = mockWeather
        }
    }
    
    private func getWeatherDescription(for weatherType: WeatherType) -> String {
        switch weatherType {
        case .sunny: return "맑음"
        case .sunset: return "일몰"
        case .sunrise: return "일출"
        case .eclipse: return "일식"
        case .partialCloudy: return "구름 조금"
        case .rainyDay: return "비 오는 날"
        case .mostlyCloud: return "대부분 흐림"
        case .fullMoon: return "보름달"
        case .halfMoon: return "반달"
        case .cloudyNight: return "흐린 밤"
        case .mostlyCloudy: return "대부분 흐림"
        case .thunder: return "천둥"
        case .thunderstorm: return "천둥번개"
        case .heavySnowfall: return "폭설"
        case .cloudLight: return "구름"
        case .cloudyNightStars: return "구름 낀 밤하늘"
        case .heavyRain: return "폭우"
        case .moonSet: return "월몰"
        case .rain: return "비"
        case .heavyWind: return "강풍"
        case .snow: return "눈"
        case .hailstrom: return "우박"
        case .drop: return "이슬"
        }
    }
    
    private func loadMockWeather() async {
        // Mock 데이터 생성
        let mockWeather = Weather(
            temperature: 22.5,
            weatherDescription: "맑음",
            humidity: 65,
            windSpeed: 3.2,
            feelsLike: 24.1,
            weatherIcon: "sun.max.fill",
            weatherType: .sunny
        )
        
        // UI 업데이트를 위해 메인 스레드에서 실행
        await MainActor.run {
            self.weather = mockWeather
        }
    }
}
