//
//  Weather.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import Foundation
 
class Weather {

    var currentWeather: CurrentWeather
    var hourlyWeather: [HourlyWeather]
    var dailyWeather: [DailyWeather]
    
    init(currentWeather: CurrentWeather = CurrentWeather(), hourlyWeather: [HourlyWeather] = [], dailyWeather: [DailyWeather] = []) {
        self.currentWeather = currentWeather
        self.hourlyWeather = hourlyWeather
        self.dailyWeather = dailyWeather
    }
    
}
