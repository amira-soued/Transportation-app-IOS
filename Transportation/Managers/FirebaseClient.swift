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
     
    func getStations(_ completion: @escaping ([Station]) -> Void){
        database.collection(productionCollection).document(stationsDocument).getDocument { (document, error) in
            var stations = [Station]()
            guard let document = document, error == nil
            else{
                completion([])
                return
            }
            let dataDescription = document.data()
            if let data = dataDescription as?  [String: [String]]{
                for stationData in data{
                    let Id = stationData.key
                    let stationInfo = stationData.value
                    let station = Station(Id: Id, name: stationInfo.first ?? "", city: stationInfo.last ?? "")
                    stations.append(station)
                }
            }
            completion(stations)
        }
    }
    
    func getDirectionSousseTrips(completion: @escaping([TripsByStation])-> Void){
        database.collection(productionCollection).document(sousseDocument).getDocument { (document, error) in
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
        database.collection(productionCollection).document(mahdiaDocument).getDocument { (document, error) in
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
