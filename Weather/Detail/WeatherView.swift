//
//  WeatherView.swift
//  Weather
//
//  Created by TKSOHLT on 08/12/23.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    var body: some View {
        ZStack {
            //MARK: Background
            Color.background
                .ignoresSafeArea()
            
            //MARK: Weather Widgets
            ScrollView(showsIndicators: false){
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
        }
        .overlay {
            //MARK: Navigation bar
            NavigationBar(searchText: $searchText)
        }
        .navigationBarHidden(true)
        //.searchable(text: $searchText, placement:
                //.navigationBarDrawer(displayMode: .always), prompt: "Search for a city or airport")
    }
}

#Preview {
    WeatherView()
        .preferredColorScheme(.dark)
}
