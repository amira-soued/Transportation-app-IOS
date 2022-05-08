//
//  Time.swift
//  Transportation
//
//  Created by MacBook Pro on 04/03/2022.
//

import Foundation

struct Time: Codable{
   let stationID : String
   let time : String
}

struct TimeByTrip: Codable{
    let tripId: String
    let times: [Time]
}

struct TripByStations: Codable{
    let id: String
    let trips: [Trip]
}
