//
//  ListView.swift
//  TopGyms
//
//  Created by Denis on 5/23/23.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel : ViewModel
    @State private var isLoading = false
    @State private var isDetail = false
    let isSearch : Bool
    var body: some View {
        NavigationView {
        VStack {
            if isSearch {
                HStack {
                    Button(action: {Task{await fetchNearby()}}) {
                        Text("Search gyms")
                            .frame(width: 170,height: 45)
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(Color.accentColor)
                            .cornerRadius(20)
                    }
                    HStack {
                        Text("Radius")
                            .padding(.leading)
                            .font(.headline)
                        Image(systemName: "chevron.up.chevron.down")
                            .padding(.trailing,-13)
                        
                        Picker("Please select a radius", selection: $viewModel.radius) {
                            PickerContent(pickerValues: viewModel.radiusArray)
                        }.pickerStyle(.wheel)
                            .onChange(of: viewModel.radius) { _ in
                                Task {
                                    await fetchNearby()
                                }
                            }
                            .padding(.leading)
                            .frame(height: 250)
                            .accentColor(.white)
                            .padding(.leading,-20)
                    }.frame(width: 170,height: 45)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                }.padding(.vertical)
            }
            
            ScrollView(showsIndicators: false) {
                if !viewModel.nearbyGyms.isEmpty {
                if isLoading == false {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.nearbyGyms) { item in
                            Button(action:{DispatchQueue.main.async { isDetail = true ; viewModel.placeID = item.placeID ?? ""}}){
                                VStack(alignment:.leading) {
                                    HStack {
                                        if item.photos?.first?.photoReference != nil {
                                            ImageView2(photoReference: item.photos?.first?.photoReference)
                                        } else {
                                            ImageView2(photoReference: item.photos?.last?.photoReference)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(item.name ?? "Unknown")
                                                .foregroundColor(.black)
                                                .font(item.name?.count ?? 0 > 20 ? .headline : .title)
                                                .bold()
                                                .multilineTextAlignment(.leading)
                                            HStack {
                                               
                                                StarsView(rating: item.rating)
                                                
                                                Text(item.openingHours?.openNow ?? false ? "Open":"Closed")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 80, height: 28)
                                                .background(item.openingHours?.openNow ?? false ? Color.green : Color.red)
                                                .cornerRadius(12)
                                                .bold()
                                            }
                                        }
                                    }
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(height: 1)
                                        .padding(.top,8)
                                }
                            }
                        }
                    }.sheet(isPresented: $isDetail) { 
                        DetailView(viewModel: viewModel)
                    }
                } else {
                    VStack {
                        Spacer()
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .scaleEffect(2.3)
                        Spacer()
                    }
                }
                } else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .scaleEffect(2.3)
                }
        }.padding(.horizontal)
        }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ViewModel(), isSearch: true)
    }
}
extension ListView {
    func fetchNearby() async {
        isLoading = true
        do {
            try await viewModel.fetchNearby()
        } catch {
            print("Fetch Data Error")
        }
        isLoading = false
    }
}

