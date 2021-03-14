//
//  MenuHeaderView.swift
//  WeatherSwiftUI
//
//  Created by Sergey Lukaschuk on 18.02.2021.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @ObservedObject var cityVM: CityViewModel
    @State private var searchTerm = "Los Angeles"
    
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .padding(.leading, 20.0)
            
            Button { cityVM.city = searchTerm } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.blue)
                    
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50.0, height: 50.0)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 10.0)
            
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.blue.opacity(0.5))
        })
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
