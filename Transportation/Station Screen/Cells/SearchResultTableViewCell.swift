//
//  SearchResultTableViewCell.swift
//  Transportation
//
//  Created by Souid, Houcem on 06/03/2022.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(startTime: Date, endTime: Date){
        //TODO: implement setup
    }
}
