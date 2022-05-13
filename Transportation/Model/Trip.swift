//
//  Trip.swift
//  Transportation
//
//  Created by MacBook Pro on 25/02/2022.
//

import Foundation

struct Trip: Codable{
    let tripTime : String
    let tripId: String
}

struct TripByStations: Codable{
    let id: String
    let trips: [Trip]
}
