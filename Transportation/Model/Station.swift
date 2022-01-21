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
}

extension Station {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Station] {
        var stations = [Station]()
        for document in documents {
            stations.append(Station(name: document["name"] as? String ?? "",
                              city: document["city"] as? String ?? ""))
        }
        return stations
    }
}
