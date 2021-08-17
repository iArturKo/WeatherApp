//
//  DailyWeather.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import Foundation

class DailyWeather {
    
    var day: String
    var iconName: String
    var tempMax: Int
    var tempMin: Int
    
    init(day: String = "", iconName: String = "", tempMax: Int = 0, tempMin: Int = 0) {
        self.day = day
        self.iconName = iconName
        self.tempMax = tempMax
        self.tempMin = tempMin
    }
    
}
