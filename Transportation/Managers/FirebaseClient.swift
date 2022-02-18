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
   
    func getStations(handler: @escaping ([Station]) -> Void) {
        database.collection("Stations").addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                } else {
                    handler(Station.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
    
    func getDepartureTrips(documentID: String){
        let docRef = database.collection("Trip by station").document(documentID)
        docRef.getDocument { snapshot , error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            self.results = data
            let times = self.results?.keys
            let trips = self.results?.values
            for t in times! {
                self.time.append(t)
            }
        }
        
    }
}
