//
//  searchHistoryTableViewCell.swift
//  Transportation
//
//  Created by MacBook Pro on 08/04/2022.
//

import UIKit

class searchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var fromHistorySearchLabel: UILabel!
    @IBOutlet weak var toHistorySearchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    func setupHistoryCell(from: String, to: String){
        fromHistorySearchLabel.text = from
        toHistorySearchLabel.text = to
    }
    
}
