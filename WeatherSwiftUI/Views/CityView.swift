//
//  CityView.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 18.02.2021.
//

import SwiftUI

struct CityView: View {
    
    @ObservedObject var cityVM: CityViewModel
    
    var body: some View {
        VStack {
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 0.0)
            TodayWeatherView(cityVM: cityVM)
                .padding()
            HourlyWeatherView(cityVM: cityVM)
            DailyWeatherView(cityVM: cityVM)
        }
        .padding(.bottom, 30.0)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
