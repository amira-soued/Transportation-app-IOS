//
//  Station.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation
import FirebaseFirestore

struct Station: Codable {
    let name : String
    let city : String
    let ID : String

    init(ID : String, name : String, city : String) {
        self.ID = ID
        self.name = name
        self.city = city
    }
}
