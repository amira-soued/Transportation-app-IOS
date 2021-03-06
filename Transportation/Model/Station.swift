//
//  Station.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation
import FirebaseFirestore

struct Station {
    var name : String?
    var city : String?
    var ID : String?

    init(ID : String?, name : String?, city : String?) {
        self.ID = ID
        self.name = name
        self.city = city
    }
}
