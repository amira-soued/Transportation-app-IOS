//
//  HistoryManger.swift
//  Transportation
//
//  Created by MacBook Pro on 10/04/2022.
//

import Foundation

struct HistoryManager {
    private let capacity = 3
    private let Key = "recent trips"
  
    func addTrip(searchedTrip : RecentTrip){
        var recentSearches: [RecentTrip] = getRecentTrips()
            if recentSearches.count < capacity {
                recentSearches.insert(searchedTrip, at: 0)
            } else {
                recentSearches.removeLast()
                recentSearches.insert(searchedTrip, at: 0)
            }
            do {
                // Encode RecentTrip
                let encoder = JSONEncoder()
                let data = try encoder.encode(recentSearches)
                // Set Data
                UserDefaults.standard.set(data, forKey: Key)
            } catch {
                print("Unable to Encode (\(error))")
            }
    }
   
    func getRecentTrips() -> [RecentTrip] {
        var trips : [RecentTrip]?
        if let data = UserDefaults.standard.data(forKey: Key) {
            // Decode
            let decoder = JSONDecoder()
            trips = try? decoder.decode([RecentTrip].self, from: data)
                return trips ?? []
        } else {
        return trips ?? []
        }
    }
}


