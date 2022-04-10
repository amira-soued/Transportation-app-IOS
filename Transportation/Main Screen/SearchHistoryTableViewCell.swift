//
//  searchHistoryTableViewCell.swift
//  Transportation
//
//  Created by MacBook Pro on 08/04/2022.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var fromHistorySearchLabel: UILabel!
    @IBOutlet weak var toHistorySearchLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerStackView.layer.borderWidth = 1
        containerStackView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupHistoryCell(from: String, to: String){
        fromHistorySearchLabel.text = from
        toHistorySearchLabel.text = to
    }
    
}
