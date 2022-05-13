//
//  Time.swift
//  Transportation
//
//  Created by MacBook Pro on 04/03/2022.
//

import Foundation

struct Time: Codable{
   let stationId : String
   let time : String
}

struct TimeByTrip: Codable{
    let tripId: String
    let times: [Time]
}

