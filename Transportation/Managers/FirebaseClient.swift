//
//  FirebaseClient.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation
import Firebase
import FirebaseAnalytics
import UIKit

class FirebaseClient{
    private let database = Firestore.firestore()
    private let remoteConfig = RemoteConfig.remoteConfig()
//
//    public var allStations = [Station]()
//    public var timeByTrips = [TimeByTrip]()
//    public var allTimes = [Time]()

    public static let shared = FirebaseClient()
    
    private init() {}
    
      // fetch the url saved in remote config
    func fetchLoadingImageUrl(completion: @escaping (String) -> Void){
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status , error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _ , error in
                    guard error == nil else {
                        return
                    }
                    let remoteConfigValue = self.remoteConfig.configValue(forKey: "urlString").stringValue ?? ""
                    completion(remoteConfigValue)
                }
            } else {
                print("Error fetching url")
            }
        })
    }
    
    func getStations(_ completion: @escaping ([Station]) -> Void) {
        database.collection("Stations").addSnapshotListener { querySnapshot, err in
            if let error = err {
                print(error)
                completion([])
            } else {
                let documents = querySnapshot?.documents ?? []
                let stations: [Station] = documents.compactMap { document in
                    if let id = document["ID"] as? String,
                       let name = document["name"] as? String,
                       let city = document["city"] as? String {
                        return Station(ID: id, name: name, city: city)
                    }
                    return nil
                }
                completion(stations)
            }
        }
    }
  
    func getTripByStation(completion: @escaping([TripByStations])-> Void){
        database.collection("Trip by station").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var tripsByStations = [TripByStations]()
                let documents = querySnapshot?.documents ?? []
                for document in documents {
                    let data = document.data()
                    var trips = [Trip]()
                    if let documentsData = data as? [String: String] {
                        trips = documentsData.map { key, value -> Trip in
                            let trip = Trip(tripTime: key, tripID: value)
                            return trip
                        }
                    }
                    tripsByStations.append(TripByStations(id: document.documentID, trips: trips))
                }
                completion(tripsByStations)
            }
        }
    }
    
    func getTimeByTrip(completion: @escaping([TimeByTrip])-> Void){
        database.collection("Time by trip").getDocuments() { (querySnapshot, error) in
            guard error == nil, let documents = querySnapshot?.documents  else {
                completion([])
                return
            }
            var timeByTrips = [TimeByTrip]()
            for document in documents {
                let data = document.data()
                var times = [Time]()
                if let documentsData = data as? [String: String?] {
                    times = documentsData.map { key, value -> Time in
                        let time = Time(stationID: key, time: value ?? "")
                        return time
                    }
                }
                timeByTrips.append(TimeByTrip(tripId: document.documentID, times: times))
            }
            completion(timeByTrips)
        }
    }
    
//    func getTrips(stationID: String, completion: @escaping([Trip])-> Void){
//        let docRef = database.collection("Trip by station").document(stationID)
//        docRef.getDocument { snapshot , error in
//            guard let data = snapshot?.data(), error == nil else {
//                return
//            }
//            let trips : [Trip] = data.map { tripData in
//                let time = tripData.key
//                let id = tripData.value as? String
//                return Trip(tripTime: time, tripID: id!)
//            }
//            let sortedTrips = trips.sorted {
//                $0.tripTime < $1.tripTime
//            }
//            completion(sortedTrips)
//        }
//    }
    
//    func getTimes(by tripID : String, completion: @escaping ([Time])-> Void){
//        let docRef = database.collection("Time by trip").document(tripID)
//        docRef.getDocument { snapshot , error in
//            guard let data = snapshot?.data(), error == nil else {
//                return
//            }
//            let trainTimes : [Time] = data.map { trainData in
//                let id = trainData.key
//                let time = trainData.value as? String
//                return Time(stationID: id, time: time!)
//            }
//            completion(trainTimes)
//        }
//    }
}
