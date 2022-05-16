//
//  FirebaseClient.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation
import Firebase
import UIKit

class FirebaseClient{
    private let database = Firestore.firestore()
    public static let shared = FirebaseClient()
    
    private init() {}
    
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
                        return Station(Id: id, name: name, city: city)
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
                            let trip = Trip(tripTime: key, tripId: value)
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
                        let time = Time(stationId: key, time: value ?? "")
                        return time
                    }
                }
                timeByTrips.append(TimeByTrip(tripId: document.documentID, times: times))
            }
            completion(timeByTrips)
        }
    }
}
