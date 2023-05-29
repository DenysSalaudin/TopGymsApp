//
//  ContentView.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : ViewModel
    init(viewModel:ViewModel) {
        self.viewModel = viewModel
        UITabBar.appearance().backgroundColor = .init(#colorLiteral(red: 1, green: 0.9474434257, blue: 0.796810627, alpha: 1))
       }
    var body: some View {
        VStack {
                TopBar(viewModel: viewModel)
                .background(Color(#colorLiteral(red: 1, green: 0.9474434257, blue: 0.796810627, alpha: 1)))
                .padding(.bottom,-8)
                .padding(.top,-12)
            TabView {
                SearchView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                SavedView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "bookmark")
                        Text("Saved")
                    }
            }
        }
        .task {
            await fetchNearby()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
extension ContentView {
    func fetchNearby() async {
        do {
            try await viewModel.fetchNearby()
        } catch {
            print("Fetch Data Error")
        }
        
    }
}
