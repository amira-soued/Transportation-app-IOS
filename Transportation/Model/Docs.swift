//
//  Docs.swift
//  Transportation
//
//  Created by MacBook Pro on 25/04/2022.
//

import Foundation
struct Docs{
    let docID : String
    let data: [String : Any]
    
    init(docID : String, data: [String : Any]){
        self.docID = docID
        self.data = data
    }
}
