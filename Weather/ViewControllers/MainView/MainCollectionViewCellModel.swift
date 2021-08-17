//
//  MainCollectionViewCellModel.swift
//  Weather
//
//  Created by Артур Кононович on 12.08.21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MainCollectionViewCellModel {
    
    var description = PublishRelay<String>()
    var image = PublishRelay<UIImage>()
    var temp = PublishRelay<String>()
    var humidity = PublishRelay<String>()
    var wind = PublishRelay<String>()
    var hourly = PublishRelay<[HourlyWeather]>()
    var daily = PublishRelay<[DailyWeather]>()
    
    
    func loadWeatherForecast(location: Location) {
        JSONManager.shared.getWeatherForecast(location: location, complition: { [weak self] weatherForecast in
            DispatchQueue.main.async {
                guard let weather = weatherForecast else {
                    return
                }
                
                self?.description.accept(weather.currentWeather.description.localized)
                self?.image.accept(UIImage(named: weather.currentWeather.iconName) ?? UIImage())
                self?.temp.accept("\(weather.currentWeather.temp)°")
                self?.humidity.accept("\(weather.currentWeather.humidity) %")
                self?.wind.accept(String(format: "%d m/s".localized, weather.currentWeather.windSpeed))
                self?.hourly.accept(weather.hourlyWeather)
                self?.daily.accept(weather.dailyWeather)

            }
        })
    }
}
