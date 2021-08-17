//
//  HourlyWeather.swift
//  Weather
//
//  Created by Артур Кононович on 8.06.21.
//

import Foundation

class HourlyWeather {
    
    var time: String
    var iconName: String
    var temp: Int
    
    internal init(time: String = "", iconName: String = "", temp: Int = 0) {
        self.time = time
        self.iconName = iconName
        self.temp = temp
    }
}
