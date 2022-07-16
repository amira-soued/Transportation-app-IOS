//
//  Trip.swift
//  Transportation
//
//  Created by MacBook Pro on 25/02/2022.
//

import Foundation

struct TripsByStation : Codable{
    let stationId : String
    let trips : [String:String]
}

