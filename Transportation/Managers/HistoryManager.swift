//
//  HistoryManger.swift
//  Transportation
//
//  Created by MacBook Pro on 10/04/2022.
//

import Foundation

struct HistoryManager {
    private let capacity = 4
    private let Key = "recent trips"
  
    func addTrip(searchedTrip : RecentTrip){
        var recentSearches: [RecentTrip] = getRecentTrips()
        let lastSeartchedStart = recentSearches.last?.start
        let lastSearchedFinish = recentSearches.last?.finish
        if lastSeartchedStart?.Id == searchedTrip.start.Id, lastSearchedFinish?.Id == searchedTrip.finish.Id {
          return
        } else {
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


