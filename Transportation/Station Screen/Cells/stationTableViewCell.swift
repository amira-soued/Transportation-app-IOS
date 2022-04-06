//
//  stationTableViewCell.swift
//  Transportation
//
//  Created by MacBook Pro on 06/04/2022.
//

import UIKit

class stationTableViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(stationName : String?, cityName : String?){
        stationNameLabel.text = stationName
        cityNameLabel.text = cityName
    }
    
}
