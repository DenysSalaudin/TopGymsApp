//
//  TopBar.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI

struct TopBar: View {
    @StateObject var viewModel : ViewModel
    var body: some View {
        HStack(spacing:1) {
            Text("TOP")
                .bold()
            Image(systemName: "dumbbell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 55,height: 55)
                .foregroundColor(.accentColor)
            Text("GYMS")
                .bold()
            Spacer()
            if viewModel.changeTopBar {
                Image(systemName: "map.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                    .font(.headline).padding(.trailing,8)
                    .onTapGesture {
                        viewModel.isList = false
                    }
                    .foregroundColor(viewModel.isList ? .black : .accentColor)
                Image(systemName: "list.bullet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                    .font(.headline)
                    .onTapGesture {
                        viewModel.isList = true
                    }
                    .foregroundColor(viewModel.isList ? .accentColor : .black)
            }
        }.font(.title)
            .padding(.horizontal)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(viewModel: ViewModel())
    }
}
