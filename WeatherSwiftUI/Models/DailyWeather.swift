//
//  DailyWeather.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 16.02.2021.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    
    var dt: Int
    var temp: Temperature
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
        case dt, temp, weather
    }
    
    init() {
        dt = 0
        temp = Temperature(min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension DailyWeather {
    var id: UUID { return UUID() }
}
