//
//  ContentView.swift
//  Weather
//
//  Created by TKSOHLT on 07/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            HomeView()
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
