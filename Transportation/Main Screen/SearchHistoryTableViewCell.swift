//
//  searchHistoryTableViewCell.swift
//  Transportation
//
//  Created by MacBook Pro on 08/04/2022.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var fromHistorySearchLabel: UILabel!
    @IBOutlet weak var toHistorySearchLabel: UILabel!

    func setupHistoryCell(from: String, to: String){
        fromHistorySearchLabel.text = from
        toHistorySearchLabel.text = to
    }
    
}
