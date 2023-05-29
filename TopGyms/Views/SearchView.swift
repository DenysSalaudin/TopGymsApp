//
//  SearchView.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel : ViewModel
    var body: some View {
        
        if viewModel.isList == false {
            MapView(viewModel: viewModel)
                .onAppear {
                    viewModel.changeTopBar = true
                }
                .onDisappear {
                    viewModel.changeTopBar = false
                }
        }
        
        if viewModel.isList == true {
            ListView(viewModel: viewModel, isSearch: true)
                .onAppear {
                    viewModel.changeTopBar = true
                }
                .onDisappear {
                    viewModel.changeTopBar = false
                }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: ViewModel())
    }
}
