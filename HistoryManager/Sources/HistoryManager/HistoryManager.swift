//
//  HistoryManger.swift
//  Transportation
//
//  Created by MacBook Pro on 10/04/2022.
//

import Foundation
import Model
public struct HistoryManager {
    public let capacity = 3
    public let Key = "recent trips"
    public init(){
        
    }
  
  public   func addTrip(searchedTrip : RecentTrip){
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
   
   public func getRecentTrips() -> [RecentTrip] {
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


