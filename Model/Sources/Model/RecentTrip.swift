//
//  recentTrip.swift
//  Transportation
//
//  Created by MacBook Pro on 19/04/2022.
//

import Foundation
public struct RecentTrip : Codable{
    public let start : Station
    public let finish : Station
    public init(start: Station, finish : Station){
        self.start = start
       self.finish = finish
    }
}
