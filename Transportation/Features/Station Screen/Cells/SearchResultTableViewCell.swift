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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let startTimeString = dateFormatter.string(from: startTime)
        let endTimeString = dateFormatter.string(from: endTime)
        timeLabel.text = startTimeString + " - " + endTimeString

        let durationTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        let durationString = formatter.string(from: durationTime)
        durationLabel.text = durationString
    }
}