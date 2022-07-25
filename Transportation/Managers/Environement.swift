//
//  Environement.swift
//  Transportation
//
//  Created by MacBook Pro on 07/05/2022.
//

import Foundation
import Models

public struct Environement {
 
    public var stations = [Station]()
    public var imageUrlString = ""
    public var directionSousseTrips = [TripsByStation]()
    public var directionMahdiaTrips = [TripsByStation]()
}

public let directionList = ["MHD","EZH","MDBA","MDSM","MDZT","BGD","BKT","TBL","TBZI","MKZI","MKN","MKGB","KSH","KHZI","SYD","LMT","BHJ","KSB","KNS","FRN","MSZI","FAC1","MST","FAC2","ARP","HTL","SHLS","SHL","SOZI","SOSUD","SOMV","SOBJ"]
public var Current = Environement()
