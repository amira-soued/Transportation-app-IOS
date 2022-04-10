//
//  HistoryManger.swift
//  Transportation
//
//  Created by MacBook Pro on 10/04/2022.
//

import Foundation

struct HistoryManager {
    private let capacity = 3
    private let recentTripsKey = "recentTrips"

    func addTrip(trip: String) {
        var recentTrips: [String] = (UserDefaults.standard.array(forKey: recentTripsKey) as? [String]) ?? []
        if recentTrips.count < capacity {
            recentTrips.insert(trip, at: 0)
        } else {
            recentTrips.removeLast()
            recentTrips.insert(trip, at: 0)
        }
        UserDefaults.standard.set(recentTrips, forKey: recentTripsKey)
    }
    
    func getRecentTrips() -> [String] {
       (UserDefaults.standard.array(forKey: recentTripsKey) as? [String]) ?? []
    }
}
