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
    var fromButtonName : String?
    var toButtonName : String?
    var departureID : String?
    var destinationID : String?
    var availableTime = [String]()
    var availableTrip = [String]()
    var availableResults = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainScreenStackView.layer.cornerRadius = 10
        fromButton.configuration?.title = fromButtonName
        toButton.configuration?.title = toButtonName
        tableView.delegate = self
        tableView.dataSource = self
        firebaseClient.getDepartureTrips(documentID: departureID!, operation: getTimeAndTrip)
    }
}

extension TrainListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "trainCell")
        cell.textLabel?.text = availableTime[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        cell.detailTextLabel?.text = availableTrip[indexPath.row]
        cell.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .light)
        return cell
    }

    func getTimeAndTrip(results : [String : Any])-> ([String : Any]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let today = Date()
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let currentTime = "\(hours):\(minutes)"
        for result in results{
            let time = result.key
            let trip = result.value
            if dateFormatter.date(from: currentTime)! < dateFormatter.date(from: time)! {
                availableTime.append(time)
                availableTrip.append(trip as! String)
                availableResults.updateValue(trip, forKey: time)
            }
        }
        print(availableResults)
        tableView.reloadData()
        return(availableResults)
    }
    
    @IBAction func backToStationScreen(_ sender: Any) {
        let coordinator = TrainListCoordinator(navigationController: navigationController)
        coordinator.dismissTrainScreen()
    }
}

