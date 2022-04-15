//
//  HistoryManger.swift
//  Transportation
//
//  Created by MacBook Pro on 10/04/2022.
//

import Foundation

struct HistoryManager {
    private let capacity = 4
    private let departureKey = "departures"
    private let destinationKey = "destinations"

    func addTrip(from: String, to: String) {
        var recentFromSearches: [String] = (UserDefaults.standard.array(forKey: departureKey) as? [String]) ?? []
        var recentToSearches: [String] = (UserDefaults.standard.array(forKey: destinationKey) as? [String]) ?? []

        if recentFromSearches.count < capacity {
            recentFromSearches.insert(from, at: 0)
            recentToSearches.insert(to, at: 0)

        } else {
            recentFromSearches.removeLast()
            recentToSearches.removeLast()
            recentFromSearches.insert(from, at: 0)
            recentToSearches.insert(to, at: 0)

        }
        UserDefaults.standard.set(recentFromSearches, forKey: departureKey)
        UserDefaults.standard.set(recentToSearches, forKey: destinationKey)
    }
    
    func getRecentDepartures() -> [String] {
       (UserDefaults.standard.array(forKey: departureKey) as? [String]) ?? []
    }
    func getRecentDestinations() -> [String] {
       (UserDefaults.standard.array(forKey: destinationKey) as? [String]) ?? []
    }
}
