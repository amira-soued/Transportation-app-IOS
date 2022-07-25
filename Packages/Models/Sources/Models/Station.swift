//
//  Station.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import Foundation

public struct Station: Codable {
  public   let Id : String
  public   let name : String
  public   let city : String
    public init(Id: String, name: String, city: String){
        self.Id = Id
        self.name = name
        self.city = city
    }
}
