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
    
    func getDirectionSousseTrips(completion: @escaping([TripsByStation])-> Void){
        database.collection("trinoo-staging").document("Mahdia-Sousse").getDocument { (document, error) in
            var trips = [TripsByStation]()
            guard let document = document, error == nil
            else{
                completion([])
                return
            }
            let dataDescription = document.data()
            if let data = dataDescription as?  [String: [String:String]]{
                for tripData in data{
                    let Id = tripData.key
                    let tripId = tripData.value
                    let trip = TripsByStation(stationId: Id, trips: tripId)
                    trips.append(trip)
                }
            }
            completion(trips)
        }
    }
    
    func getDirectionMahdiaTrips(completion: @escaping([TripsByStation])-> Void){
        database.collection("trinoo-staging").document("Sousse-Mahdia").getDocument { (document, error) in
            var trips = [TripsByStation]()
            guard let document = document, error == nil
            else{
                completion([])
                return
            }
            let dataDescription = document.data()
            if let data = dataDescription as?  [String: [String:String]]{
                for tripData in data{
                    let Id = tripData.key
                    let tripId = tripData.value
                    let trip = TripsByStation(stationId: Id, trips: tripId)
                    trips.append(trip)
                }
            }
            completion(trips)
        }
    }
 
}
