//
//  TrainListViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 07/02/2022.
//

import UIKit

class TrainListViewController: UIViewController {
   
    @IBOutlet weak var trainScreenStackView: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    var viewModel = StationViewModel()
    var configuration = UIButton.Configuration.filled()
    var firebaseClient = FirebaseClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainScreenStackView.layer.cornerRadius = 10
        fromButton.configuration?.title = "fromStation"
        
    }
    
    @IBAction func backToStationScreen(_ sender: Any) {
        let coordinator = TrainListCoordinator(navigationController: navigationController)
        coordinator.dismissTrainScreen()
    }
}
