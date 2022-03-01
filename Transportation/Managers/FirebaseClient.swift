//
//  FirebaseClient.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation
import FirebaseFirestore
import Firebase

class FirebaseClient{
    let database = Firestore.firestore()
    
    func getStations(_ completion: @escaping ([Station]) -> Void) {
        database.collection("Stations").addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                    completion([])
                } else {
                    let documents = querySnapshot?.documents ?? []
                    let stations: [Station] = documents.map { document in
                        let id = document["ID"] as? String
                        let name = document["name"] as? String
                        let city = document["city"] as? String
                        return Station(ID: id, name: name, city: city)
                    }
                    completion(stations)
                }
            }
    }

    func getDepartureTrips(documentID: String, operation: @escaping([Trip])-> Void){
        var trips = [Trip]()
        let docRef = database.collection("Trip by station").document(documentID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            for tripData in data{
                let tripName = tripData.value
                let tripTime = tripData.key
                trips.append(Trip(tripTime: tripTime , tripID: tripName as? String ?? ""))
            }
            operation(trips)
        }
    }
    
    func getArrivalTime(documentID : String){
        let docRef = database.collection("Time by trip").document(documentID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            let destinationResults = data
            for result in destinationResults{
                let station = result.key
                let destinationTime = result.value as? String
                if station == documentID{
                let arrivalStationID = station
                let arrivalTime = destinationTime
                }
            }
        }
    }
     
}
