//
//  MapView.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import SwiftUI
import CoreLocationUI
import MapKit
import CoreLocation

struct MapView: View {
    @ObservedObject var viewModel : ViewModel
    @State private var isLoading = false
    @State private var zoomScale: CGFloat = 1.0
    @State private var isZoomEnabled = true
    @GestureState private var currentScale: CGFloat = 1.0
    @State private var isDetail = false
    @State private var isupdate = false
    let maxZoomScale : CGFloat = 2.0
    var body: some View {
        NavigationView {
            ZStack {
                    Map(coordinateRegion: $viewModel.region,annotationItems: viewModel.nearbyGyms) { item in
                        MapAnnotation(coordinate: CLLocationCoordinate2D.init(latitude: item.geometry?.location?.lat ?? 0.0, longitude: item.geometry?.location?.lng ?? 0.0)) {
                            Button(action:{isDetail = true; viewModel.placeID = item.placeID ?? ""}) {
                                VStack {
                                    if let photo = item.photos?.first?.photoReference {
                                        ZStack {
                                            ImageView(photoReference: photo)
                                            StarsView(rating: item.rating)
                                                .padding(2.5)
                                                .background(Color(#colorLiteral(red: 0.8488113284, green: 0.8388827443, blue: 0.8001789451, alpha: 1)))
                                                .cornerRadius(12)
                                                .padding()
                                                .offset(y:32)
                                                .scaleEffect(0.7)
                                        }
                                    } else {
                                        ZStack {
                                            ImageView(photoReference: item.photos?.last?.photoReference)
                                            StarsView(rating: item.rating)
                                                .padding(2.5)
                                                .background(Color(#colorLiteral(red: 0.8488113284, green: 0.8388827443, blue: 0.8001789451, alpha: 1)))
                                                .cornerRadius(12)
                                                .padding()
                                                .offset(y:32)
                                                .scaleEffect(0.7)
                                        }
                                    }
                                    Text(item.name ?? "unknown")
                                        .frame(width:120)
                                        .font(.headline)
                                        .bold()
                                        .lineLimit(2)
                                        .scaleEffect(0.8)
                                        .foregroundColor(.black)
                                        .padding(.top,-10)
                                }.sheet(isPresented: $isDetail) {
                                    DetailView(viewModel: viewModel)
                                }
                            }
                        }
                    }.onChange(of: viewModel.userLatitude) { _ in
                        if isupdate == false {
                            viewModel.updateMapRegion()
                        }
                        isupdate = true
                    }
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
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
                    }.padding(.bottom)
                }
            }.overlay {
                if isLoading {
                    ProgressView()
                        .padding(.bottom,20)
                        .scaleEffect(2.3)
                        .font(.headline)
                }
            }
            .onDisappear {
                viewModel.radius = 3000
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: ViewModel())
    }
}
extension MapView {
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

struct PickerContent<Data>: View where Data : RandomAccessCollection, Data.Element : Hashable {
    let pickerValues: Data
    var body: some View {
        ForEach(pickerValues, id: \.self) {
            let text = "\($0)"
            Text(text).foregroundColor(.white)
        }
    }
}



