//
//  DetailVIew.swift
//  TopGyms
//
//  Created by Denis on 5/25/23.
//

import SwiftUI
import MapKit
import Combine
struct DetailView: View {
    @ObservedObject var viewModel : ViewModel
    @State private var directions: [String] = []
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoading = false
    @State private var isMap = false
    @State private var isSaved = false
    @State var gym = GymsEntity()
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack(alignment:.leading) {
            Text(viewModel.locationDetailView?.name ?? "--------")
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    .padding(.top)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                HStack {
                    Text("\(viewModel.locationDetailView?.rating?.asCurrencyWith2Decimals() ?? "----")")
                        .foregroundColor(.black)
                    StarsView(rating: viewModel.locationDetailView?.rating ?? 0.0)
                    Text("\("(\(viewModel.locationDetailView?.userRatingsTotal ?? 0))")")
                        .foregroundColor(.black)
                    Text(viewModel.locationDetailView?.openingHours?.openNow ?? false ? "Open":"Closed")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 90,height: 32)
                    .background(viewModel.locationDetailView?.openingHours?.openNow ?? false ? Color.green : Color.red)
                    .cornerRadius(12)
                }
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 1)
                    .foregroundColor(.accentColor)
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                if let photo = viewModel.locationDetailView?.photos?.first?.photoReference {
                                    ImageView3(photoReference: photo)
                                } else {
                                    ProgressView()
                                        .frame(width: 200,height:300)
                                }
                                LazyHGrid(rows: gridItems) {
                                    ForEach(viewModel.locationDetailView?.photos?.dropFirst() ?? [],id: \.photoReference) { photo in
                                        if let photo = photo.photoReference {
                                            ImageView4(photoReference: photo)
                                        } else {
                                            ProgressView()
                                                .frame(width: 120,height:120)
                                        }
                                    }
                                }
                            }
                        }
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 1)
                        .foregroundColor(.accentColor)
                    HStack {
                        Button(action:{isMap = true}){
                            HStack {
                                Text("Directions")
                                Image(systemName: "location")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 130,height: 45)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                        }.disabled(((viewModel.locationDetailView?.name) == nil))
                            Spacer()
                        Button(action:{
                            let hasPosterPath = viewModel.gymsEntity.contains(where: { $0.placeID == viewModel.placeID })
                            if !isSaved {
                            isSaved = true
                                if !hasPosterPath  {
                                    viewModel.addGym(PlaceID: viewModel.locationDetailView?.placeID ?? "")
                                }
                            } else {
                                if viewModel.isDismiss {
                                    presentationMode.wrappedValue.dismiss()
                                    viewModel.deleteGym(gym)
                                    
                                }
                            }
                            
                        }) {
                                    HStack {
                                        Text(isSaved ? "Saved":"Save")
                                            .lineLimit(1)
                                        Image(systemName: isSaved ? "bookmark.fill":"bookmark")
                                   }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 130,height: 45)
                                .background(isSaved ? Color.gray.opacity(0.6):Color.accentColor.opacity(0.6))
                                .cornerRadius(12)
                    
                        }
                    }.padding()
                        .sheet(isPresented: $isMap) {
                            ZStack {
                                MapView2(viewModel: viewModel,directions: $directions)
                                    .ignoresSafeArea(.all)
                                VStack {
                                    HStack {
                                        Image(systemName: "chevron.left.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40,height:40)
                                        Spacer()
                                    }
                                    .foregroundColor(.accentColor)
                                    Spacer()
                                }.padding()
                                    .onTapGesture {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                        }
                    if let review = viewModel.locationDetailView?.reviews {
                        Group {
                            VStack(alignment: .leading) {
                                Text("Reviews")
                                    .bold()
                                    .padding(.bottom,-8)
                                    .padding(.top,20)
                                    .font(.title)
                                    .onTapGesture {
                                        viewModel.deleteAll()
                                    }
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 1)
                                    .foregroundColor(.accentColor)
                                
                                ForEach(viewModel.locationDetailView?.reviews ?? [],id: \.authorName) { item in
                                    HStack(alignment:.top) {
                                        AsyncImage(url: URL(string: item.profilePhotoURL ?? "")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 40,height: 40)
                                        VStack(alignment: .leading) {
                                            Text(item.text ?? "")
                                            HStack {
                                                Text("(\(item.rating ?? 0))")
                                                    .multilineTextAlignment(.leading)
                                                StarsView(rating: Double(item.rating ?? 0))
                                                Text("\(item.relativeTimeDescription ?? "------")")
                                                    .font(.caption)
                                                    .offset(y:4)
                                                    .foregroundColor(.gray)
                                            }.font(.headline)
                                        }
                                    }
                                }
                            }.foregroundColor(.black)
                        }
                    }
                    Group {
                            Text("Details")
                                .bold()
                                .padding(.bottom,-8)
                                .padding(.top,20)
                                .font(.title)
                                .foregroundColor(.black)
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 1)
                                .foregroundColor(.accentColor)
                        if let day = viewModel.locationDetailView?.currentOpeningHours?.weekdayText {
                            VStack(alignment: .leading) {
                                ForEach(day,id: \.self) { item in
                                    Text("\(item)")
                                        .font(.headline)
                                        .padding(4)
                                }
                            }.padding(12)
                                .background(Color(#colorLiteral(red: 0.8488113284, green: 0.8388827443, blue: 0.8001789451, alpha: 1)).opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.black)
                        }
                        if let adress = viewModel.locationDetailView?.formattedAddress {
                            Text("Adress: \(adress)")
                                .font(.headline)
                                .padding(.bottom,8)
                                .padding(.leading,10)
                                .foregroundColor(.black)
                        } else {
                        }
                        if let phone = viewModel.locationDetailView?.formattedPhoneNumber  {
                            Text("Phone: \(phone)")
                                .font(.headline)
                                .padding(.leading,10)
                                .foregroundColor(.black)
                                .padding(.bottom,80)
                        }
                    }
                    
               }
        }
      }
        .task {
          await fetchLocationDetail()
      }
        .padding(.horizontal)
        .onDisappear {
            viewModel.placeID = ""
            viewModel.locationDetailView = nil
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: ViewModel())
    }
    
}

extension DetailView {
    func fetchLocationDetail() async {
        isLoading = true
        do {
            try await viewModel.fetchLocationDetail()
        } catch {
            print("Fetch Data Error")
        }
        isLoading = false
    }
}
