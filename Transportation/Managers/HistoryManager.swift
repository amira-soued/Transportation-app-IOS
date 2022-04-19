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
    private let destinationKey = "destinations"
   
    func addTrip(searchedTrip : RecentTrip) {

        var recentSearches: [RecentTrip] = (UserDefaults.standard.array(forKey: Key) as? [RecentTrip]) ?? []
        
        if recentSearches.count < capacity {
            recentSearches.insert(searchedTrip, at: 0)
        } else {
            recentSearches.removeLast()
            recentSearches.insert(searchedTrip, at: 0)
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(recentSearches), forKey: Key)

//        UserDefaults.standard.set(recentFromSearches, forKey: departureKey)
//        UserDefaults.standard.set(recentToSearches, forKey: destinationKey)
    }
    
    func getRecentTrips() -> [RecentTrip] {
//       (UserDefaults.standard.array(forKey: departureKey) as? [Station]) ?? []
        var userData: [RecentTrip]?
        if let data = UserDefaults.standard.value(forKey: Key) as? Data {
                    userData = try? PropertyListDecoder().decode([RecentTrip].self , from: data)
                    return userData ?? []
                } else {
                    return userData ?? []
                }
    }

}
