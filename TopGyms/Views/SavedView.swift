//
//  SavedView.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI

struct SavedView: View {
    @ObservedObject var viewModel : ViewModel
    @State private var isDetails = false
    var body: some View {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius:1)
                            .frame(height: 35)
                            .foregroundColor(.accentColor.opacity(0.7))
                        Text("Saved")
                            .foregroundColor(Color.white)
                            .font(.headline.bold())
                    }
                    .padding(.top)
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.gymsEntity.reversed()) { gym in
                                Button(action:{  viewModel.placeID = gym.placeID ?? ""; isDetails = true}) {
                                    SavedListItem(placeID: gym.placeID ?? "", viewModel: viewModel)
                                }
                            }
                        }.sheet(isPresented: $isDetails) {
                            DetailView(viewModel: viewModel)
                        }
                    }.padding(.horizontal)
                }.onAppear {
                    viewModel.fetchGyms()
                }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView(viewModel: ViewModel())
    }
}
