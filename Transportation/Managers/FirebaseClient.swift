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

    func getStations(handler: @escaping ([Station]) -> Void) {
        database.collection("Stations").addSnapshotListener { querySnapshot, err in
                if let error = err {
                    print(error)
                } else {
                    handler(Station.build(from: querySnapshot?.documents ?? []))
                }
            }
    }
}
