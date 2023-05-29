//
//  ViewModel.swift
//  TopGyms
//
//  Created by Denis on 5/22/23.
//

import CoreData
import Foundation
import SwiftUI
import CoreLocation
import MapKit
@MainActor
class ViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    let container : NSPersistentContainer
    override init() {
         container = NSPersistentContainer(name: "GymsContainer")
         container.loadPersistentStores { descriptions, error in
             if let error = error {
                 print("ERROR LOADING CORE DATA. \(error)")
             } else {
                 print("Successfulv loaded coredata")
             }
         }
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }

    @Published var nearbyGyms : [NearbyResult] = []
    @Published var locationDetailView : DetailsResult?
    @Published var gymsEntity : [GymsEntity] = []
    @Published var placeID = ""
    @Published var region = MKCoordinateRegion()
    @Published var location: CLLocationCoordinate2D?
    @Published var userLatitude = 0.0
    @Published var userLongitude = 0.0
    @Published var isList = false
    @Published var radius = 3000 // in meters
    @Published var type = "Gym"
    @Published var keyword = "Fitnes"
    @Published var changeTopBar: Bool = UserDefaults.standard.bool(forKey: "changeTopBar") {
            didSet {
                UserDefaults.standard.set(changeTopBar, forKey: "changeTopBar")
            }
        }
    let radiusArray = [1000, 2000, 3000, 4000, 5000, 6000,7000,8000,9000,10000,13000,16000,19000,22000,25000,28000,31000,34000,37000,40000,45000,50000,55000,60000,65000,70000,75000,80000,85000,90000,95000,99999]
    private let API_KEY = "API_KEY"
    private let decoder = JSONDecoder()
    @Published var isDismiss: Bool = false
    
//API FETCH
    func fetchNearby() async throws {
        do {
            guard let feedUrl = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(userLatitude),\(userLongitude)&radius=\(radius)&type=\(type)&keyword=\(keyword)&key=\(API_KEY)") else { return }
            let (data,_) = try await URLSession.shared.data(from: feedUrl)
            let allData = try decoder.decode(NearbyLocation.self, from: data)
            self.nearbyGyms = allData.results ?? []
            print(nearbyGyms.count)
        } catch {
            print("Fetch data error")
        }
    }
    
    func fetchLocationDetail() async throws {
        do {
            guard let feedUrl = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?&place_id=\(placeID)&key=\(API_KEY)") else { return }
            let (data,_) = try await URLSession.shared.data(from: feedUrl)
            let allData = try decoder.decode(LocationDetails.self, from: data)
            self.locationDetailView = allData.result
        } catch {
            
        }
    }
    
//CORE DATA
    
    func fetchGyms() {
        let request = NSFetchRequest<GymsEntity>(entityName: "GymsEntity")
        DispatchQueue.main.async {
            do {
                self.gymsEntity = try self.container.viewContext.fetch(request)
            } catch let error {
                print("error fetching: \(error)")
            }
        }
    }
    
    func deleteGym(_ gym: GymsEntity ) {
        print("Start Deleting")
        container.viewContext.delete(gym)
        saveData()
        print("Finish Deleting")
    }
    
    func addGym(PlaceID:String) {
        let newGym = GymsEntity(context: container.viewContext)
        newGym.placeID = PlaceID
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchGyms()
        } catch let error {
            print("ERROR saving/ \(error)")
        }
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = GymsEntity .fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
//CORE LOCATION
    
    let manager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async() {
            self.userLatitude = locations.last?.coordinate.latitude ?? 0.0
            self.userLongitude = locations.last?.coordinate.longitude ?? 0.0
            self.location = locations.first?.coordinate
        }
    }
    
    func requestLocation() {
         manager.requestWhenInUseAuthorization()
         manager.startUpdatingLocation()
     }
    
    func updateMapRegion() {
           if let location = location {
               region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
           }
       }
    
    
}
