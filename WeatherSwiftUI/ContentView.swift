//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 15.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cityVM = CityViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0.0) {
                MenuHeaderView(cityVM: cityVM).padding()
                ScrollView(showsIndicators: false) {
                    CityView(cityVM: cityVM)
                }
                .padding(.top, 10)
            }
            .padding(.top, 40.0)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3588655889, green: 0.6233909726, blue: 0.9424078465, alpha: 1)), Color(#colorLiteral(red: 0.2855035067, green: 0.5642959476, blue: 0.8873009086, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
