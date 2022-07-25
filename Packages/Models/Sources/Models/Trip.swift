//
//  Trip.swift
//  Transportation
//
//  Created by MacBook Pro on 25/02/2022.
//

import Foundation

public struct TripsByStation : Codable{
   public  let stationId : String
    public let trips : [String:String]
    public init(stationId : String, trips:[String:String] ){
        self.stationId = stationId
        self.trips = trips
    }
}

