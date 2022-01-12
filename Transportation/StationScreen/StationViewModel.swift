//
//  StationViewModel.swift
//  Transportation
//
//  Created by MacBook Pro on 12/01/2022.
//

import Foundation
import UIKit

class StationViewModel{
    
    func placeholderWhite(text: String, textField : UITextField){
        let placeholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
        textField.attributedPlaceholder = placeholder
    }
    
}
