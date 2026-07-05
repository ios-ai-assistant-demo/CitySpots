//
//  CitySpotsApp.swift
//  CitySpots
//
//  Created by Trofim Petianov on 26.06.2026.
//

import SwiftUI

@main
struct CitySpotsApp: App {
    @StateObject private var store = CitySpotsStore()

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
