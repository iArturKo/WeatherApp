//
//  JSONManager.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import Foundation

class JSONManager {
    
    static let shared = JSONManager()
    private init() {}
    
    let dateFormatter = DateFormatter()
    
    func getWeatherForecast(location: Location, complition: @escaping (Weather?) -> Void) {
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "HH:mm"
        
        let weatherForecast = Weather()
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.coordinates.latitude)&lon=\(location.coordinates.longitude)&units=metric&appid=100b3279501442e4ed39a53444afb433&exclude=minutely") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        
                        guard let current = json["current"] as? [String: Any] else {
                            return
                        }
                        guard let weather = current["weather"] as? [[String: Any]] else {
                            return
                        }
                        if let description = weather[0]["description"] as? String {
                            weatherForecast.currentWeather.description = description
                        }
                        if let iconName = weather[0]["icon"] as? String {
                            weatherForecast.currentWeather.iconName = iconName
                        }
                        if let temp = current["temp"] as? Double {
                            weatherForecast.currentWeather.temp = Int(temp.rounded())
                        }
                        if let humidity = current["humidity"] as? Double {
                            weatherForecast.currentWeather.humidity = Int(humidity.rounded())
                        }
                        if let windSpeed = current["wind_speed"] as? Double {
                            weatherForecast.currentWeather.windSpeed = Int(windSpeed.rounded())
                        }
                        
                        self.dateFormatter.dateFormat = "HH"
                        
                        guard let hourly = json["hourly"] as? [[String: Any]] else {
                            return
                        }
                        for index in 0...24 {
                            var localTime = ""
                            var iconName = ""
                            var temp = 0
                            if let time = hourly[index]["dt"] as? Double {
                                let date = Date(timeIntervalSince1970: time)
                                localTime = self.dateFormatter.string(from: date)
                            }
                            
                            guard let hourlyWeather = hourly[index]["weather"] as? [[String: Any]] else {
                                return
                            }
                            if let icon = hourlyWeather[0]["icon"] as? String {
                                iconName = icon
                            }
                            
                            if let tempHourly = hourly[index]["temp"] as? Double {
                                temp = Int(tempHourly.rounded())
                            }
                            weatherForecast.hourlyWeather.append(HourlyWeather(time: localTime, iconName: iconName, temp: temp))
                        }
                        
                        self.dateFormatter.dateFormat = "EEEE"
                                            
                        guard let daily = json["daily"] as? [[String: Any]] else {
                            return
                        }
                        
                        for dailyW in daily {
                            var day = ""
                            var iconName = ""
                            var tempMax = 0
                            var tempMin = 0
                            
                            if let time = dailyW["dt"] as? Double {
                                let date = Date(timeIntervalSince1970: time)
                                day = self.dateFormatter.string(from: date).capitalized
                            }
                            
                            guard let dailyWeather = dailyW["weather"] as? [[String: Any]] else {
                                return
                            }
                            if let icon = dailyWeather[0]["icon"] as? String {
                                iconName = icon
                            }
                            
                            guard let temp = dailyW["temp"] as? [String: Any] else {
                                return
                            }
                            if let max = temp["max"] as? Double {
                                tempMax = Int(max.rounded())
                            }
                            if let min = temp["min"] as? Double {
                                tempMin = Int(min.rounded())
                            }
                            
                            weatherForecast.dailyWeather.append(DailyWeather(day: day, iconName: iconName, tempMax: tempMax, tempMin: tempMin))
                            
                            complition(weatherForecast)
                        }
                    } else {
                        complition(nil)
                    }
                } catch {
                    print(error)
                    complition(nil)
                }
            } else {
                complition(nil)
            }
        }.resume()
    }
}
