//
//  TopGymsApp.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI
@main
struct TopGymsApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
