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
        timeLabel.text = startTimeString + " -> " + endTimeString
        timeLabel.font = UIFont(name: "Roboto-Medium", size: 20)
        let durationTime = endTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.hour, .minute]
        let durationString = formatter.string(from: durationTime)
        durationLabel.text = durationString
        durationLabel.font = UIFont(name: "Roboto-Light", size: 18)
    }
}
