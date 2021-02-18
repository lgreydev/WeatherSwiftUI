//
//  DailyWeatherView.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 18.02.2021.
//

import SwiftUI

struct DailyWeatherView: View {
    
    @ObservedObject var cityVM: CityViewModel
    
    var body: some View {
        ForEach(cityVM.weather.daily) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            }
        }
    }
    
    private func dailyCell(weather: DailyWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt).uppercased())
                .frame(width: 50.0)
            Spacer()
            Text("\(cityVM.getTempFor(temp: weather.temp.max)) | \(cityVM.getTempFor(temp: weather.temp.min)) ℃")
                .frame(width: 150.0)
            Spacer()
            cityVM.getWeatherIconFor(inon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40.0)
        .padding(.vertical, 15.0)
        .background(RoundedRectangle(cornerRadius: 5.0)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3588655889, green: 0.6233909726, blue: 0.9424078465, alpha: 1)), Color(#colorLiteral(red: 0.2855035067, green: 0.5642959476, blue: 0.8873009086, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 2, y: 2)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
