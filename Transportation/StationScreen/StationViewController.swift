//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit

class StationViewController: UIViewController {

    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var FromTextField: UITextField!
    @IBOutlet weak var ToTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    let viewModel = StationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationScreenStackView.layer.cornerRadius = 10
        viewModel.placeholderWhite(text: "From:", textField: FromTextField)
        viewModel.placeholderWhite(text: "To:", textField: ToTextField)
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
            return
        }
        trainViewController.modalPresentationStyle = .fullScreen
        present(trainViewController, animated: false)
    }
    
}
