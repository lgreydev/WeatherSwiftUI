//
//  CityViewModel.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 17.02.2021.
//

import SwiftUI
import CoreLocation

final class CityViewModel: ObservableObject {
    
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "Zaporizhzhia" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
         getLocation()
    }
    
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return ""
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return "sun.max.fill"
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let paces = placemarks, let place = paces.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9886)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>
            .fetch(for: URL(string: urlString)!) { (result) in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async { self.weather = response }
                case .failure(let err):
                    print(err)
                }
            }
         }
    
    
    
}




