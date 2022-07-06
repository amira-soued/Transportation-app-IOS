//
//  stationTableViewCell.swift
//  Transportation
//
//  Created by MacBook Pro on 06/04/2022.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(stationName : String?, cityName : String?){
        stationNameLabel.text = stationName
        stationNameLabel.font = UIFont(name: "Roboto-Medium", size: 20)
        cityNameLabel.text = cityName
        cityNameLabel.font = UIFont(name: "Roboto-Regular", size: 15)
    }
    
}
