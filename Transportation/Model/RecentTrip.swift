//
//  recentTrip.swift
//  Transportation
//
//  Created by MacBook Pro on 19/04/2022.
//

import Foundation
struct RecentTrip : Codable{
    let start : Station
    let finish : Station
    
    init(start : Station, finish: Station){
        self.start = start
        self.finish = finish
    }
}
