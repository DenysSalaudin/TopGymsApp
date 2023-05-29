//
//  SavedModel.swift
//  TopGyms
//
//  Created by Denis on 5/27/23.
//

import Foundation
import SwiftUI
class SavedModel: ObservableObject {
    @Published var name: String = ""
    @Published var photoReference = ""
    @Published var rating: Double = 0
    @Published var openNow: Bool = false
    @Published var lat: Double = 0.0
    @Published var lon: Double = 0.0
    var placeID: String?
    
    init(placeID: String? = nil) {
        self.placeID = placeID
            Task {
                await fetch()
            }
    }
    private let API_KEY = "API_KEY"
 
    func fetchLocationDetail() async throws {
        do {
            guard let feedUrl = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?&place_id=\(placeID ?? "")&key=\(API_KEY)") else { return }
            let (data,_) = try await URLSession.shared.data(from: feedUrl)
            let allData = try JSONDecoder().decode(LocationDetails.self, from: data)
            DispatchQueue.main.async {
                self.name = allData.result?.name ?? ""
                self.photoReference = allData.result?.photos?.first?.photoReference ?? ""
                self.rating = allData.result?.rating ?? 0.0
                self.openNow = allData.result?.openingHours?.openNow ?? false
                self.lat = allData.result?.geometry?.location?.lat ?? 0.0
                self.lon = allData.result?.geometry?.location?.lng ?? 0.0
            }
        } catch {
            print("Error")
        }
    }
    
    func fetch() async {
        do {
           try await fetchLocationDetail()
        } catch {
            print("Error")
        }
    }
    
}
