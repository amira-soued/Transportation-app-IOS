//
//  MainScreenViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit

class MainScreenViewController: UIViewController {
  
    @IBOutlet weak var homeScreenStackView: UIStackView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenStackView.layer.cornerRadius = 10
    }
 
    @IBAction func clickOnButton(_ sender: UIButton) {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController!)
        mainScreenCoordinator.showStation(toButtonClicked: sender == toButton)
    }
}
 
