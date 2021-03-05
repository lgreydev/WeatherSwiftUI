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
        return "dayClearSky"
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
        return String(format: "%0.0f%%", weather.current.uvi)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.0f", temp)
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
    
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayClearSky" // ok
        case "01n":
            return "nightClearSky" // ok
        case "02d":
            return "dayFewClouds" // ok
        case "02n":
            return "nightFewClouds" // ok
        case "03d":
            return "dayScatteredClouds" // ok
        case "03n":
            return "nightScatteredClouds" // ok
        case "04d":
            return "dayBrokenClouds" // ok
        case "04n":
            return "nightBrokenClouds" // ok
        case "09d":
            return "dayShowerRains" // ok
        case "09n":
            return "nightShowerRains" // ok
        case "10d":
            return "dayRain" // ok
        case "10n":
            return "nightRain" // ok
        case "11d":
            return "dayThunderstorm" // ok
        case "11n":
            return "nightThunderstorm" // ok
        case "13d":
            return "daySnow" // ok
        case "13n":
            return "nightSnow" // ok
        case "50d":
            return "dayMist" // ok
        case "50n":
            return "nightMist" // ok
        default:
            return "dayClearSky" // ok
        }
    }
  
    func getWeatherIconFor(inon: String) -> Image {
        switch inon {
        case "01d":
            return Image(systemName: "sun.max.fill") // clear_sky_day
        case "01n":
            return Image(systemName: "moon.fill") // clear_sky_night"
        case "02d":
            return Image(systemName: "cloud.sun.fill") // few_clouds_day
        case "02n":
            return Image(systemName: "cloud.moon.fill") // few_clouds_night
        case "03d":
            return Image(systemName: "cloud.fill") // scattered_clouds
        case "03n":
            return Image(systemName: "cloud.fill") // scattered_clouds
        case "04d":
            return Image(systemName: "cloud.fill") // broken_clouds
        case "04n":
            return Image(systemName: "cloud.fill") // broken_clouds
        case "09d":
            return Image(systemName: "cloud.drizzle.fill") // shower_rain
        case "09n":
            return Image(systemName: "cloud.drizzle.fill") // shower_rain
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill") // rain_day
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill") // rain_night
        case "11d":
            return Image(systemName: "cloud.bolt.fill") // thunderstorm_day
        case "11n":
            return Image(systemName: "cloud.bolt.fill") // thunderstorm_night
        case "13d":
            return Image(systemName: "cloud.hail") // show
        case "13n":
            return Image(systemName: "cloud.hail.fill") // show
        case "50d":
            return Image(systemName: "cloud.fog.fill") // mist
        case "50n":
            return Image(systemName: "cloud.fog.fill") // mist
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}




