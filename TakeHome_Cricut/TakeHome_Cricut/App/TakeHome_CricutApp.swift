//
//  TakeHome_CricutApp.swift
//  TakeHome_Cricut
//
//  Created by Ben Oveson on 4/6/25.
//

import SwiftUI

@main
struct TakeHome_CricutApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
