//
//  Environement.swift
//  Transportation
//
//  Created by MacBook Pro on 07/05/2022.
//

import Foundation

struct Environement {
 
    var stations = [Station]()
    var imageUrlString = ""
    var directionSousseTrips = [TripsByStation]()
    var directionMahdiaTrips = [TripsByStation]()
}

let directionList = ["MHD","EZH","MDBA","MDSM","MDZT","BGD","BKT","TBL","TBZI","MKZI","MKN","MKGB","KSH","KHZI","SYD","LMT","BHJ","KSB","KNS","FRN","MSZI","FAC1","MST","FAC2","ARP","HTL","SHLS","SHL","SOZI","SOSUD","SOMV","SOBJ"]
var Current = Environement()
