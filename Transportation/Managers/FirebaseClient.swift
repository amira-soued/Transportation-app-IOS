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

    func getTrips(stationID: String, completion: @escaping([Trip])-> Void){
        let docRef = database.collection("Trip by station").document(stationID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            let trips : [Trip] = data.map { tripData in
                let time = tripData.key
                let id = tripData.value as? String
                return Trip(tripTime: time, tripID: id!)
            }
            let sortedTrips = trips.sorted {
                $0.tripTime < $1.tripTime
            }
            completion(sortedTrips)
        }
    }
    
    func getTimes(by tripID : String, completion: @escaping ([Time])-> Void){
        let docRef = database.collection("Time by trip").document(tripID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            let trainTimes : [Time] = data.map { trainData in
                let id = trainData.key
                let time = trainData.value as? String
                return Time(stationID: id, time: time!)
            }
            completion(trainTimes)
        }
    }
     
}
