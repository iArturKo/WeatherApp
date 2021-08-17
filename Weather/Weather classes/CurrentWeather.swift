//
//  CurrentWeather.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import Foundation

class CurrentWeather {
    
    var description: String
    var iconName: String
    var temp: Int
    var humidity: Int
    var windSpeed: Int
    
    init(description: String = "", iconName: String = "", temp: Int = 0, humidity: Int = 0, windSpeed: Int = 0) {
        self.description = description
        self.iconName = iconName
        self.temp = temp
        self.humidity = humidity
        self.windSpeed = windSpeed
    }

}
