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
    var results : [String : Any]?
    var time = [String]()
    var trip = [String]()
   
    let dateFormatter = DateFormatter()
    var availableTime = [String]()
    var availableTrip = [String]()
    var stationResults : (departureTime: [String], departureTrip: [String])?
    
    func getStations(handler: @escaping ([Station]) -> Void) {
        database.collection("Stations").addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                } else {
                    handler(Station.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
//
//    func getDepartureTrips(documentID: String)-> (departureTime : [String], departureTrip : [String]){
//        dateFormatter.dateFormat = "HH:mm"
//        let hours   = (Calendar.current.component(.hour, from: today))
//        let minutes = (Calendar.current.component(.minute, from: today))
//        let currentTime = "\(hours):\(minutes)"
//
//        let docRef = database.collection("Trip by station").document(documentID)
//        docRef.getDocument { snapshot , error in
//            guard let data = snapshot?.data(), error == nil else {
//                return
//            }
//            self.results = data
//            for result in self.results!{
//                let time = result.key
//                let trip = result.value
//                if self.dateFormatter.date(from: currentTime)! < self.dateFormatter.date(from: time)! {
//                    self.availableTime.append(time)
//                    self.availableTrip.append(trip as! String)
//                }
//            }
//        }
//        return(availableTime, availableTrip)
//    }
    
    func getDepartureTrips(documentID: String, operation: @escaping([String : Any])-> (departureTime : [String], departureTrip : [String])){
        
        
        let docRef = database.collection("Trip by station").document(documentID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            self.results = data
            self.stationResults = operation(self.results!)
            self.availableTime = self.stationResults!.departureTime
            self.availableTrip = self.stationResults!.departureTrip
            
        }
        
       
    }
    
}
