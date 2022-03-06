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
    
    var configuration = UIButton.Configuration.filled()
    var firebaseClient = FirebaseClient()
    var fromButtonName : String?
    var toButtonName : String?
    var departureID : String = ""
    var destinationID : String = ""
    var availableResults = [String : Any]()
    var arrivalTime : String?
    var nearestTrip : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainScreenStackView.layer.cornerRadius = 10
        fromButton.configuration?.title = fromButtonName
        toButton.configuration?.title = toButtonName
        firebaseClient.getTrips(stationID: departureID, completion: getTimeAndTrip)
        
    }

    func getTimeAndTrip(results : [Trip]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let today = Date()
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let currentTime = "\(hours):\(minutes)"
  
        for result in results{
            let time = result.tripTime
            let trip = result.tripID
            if dateFormatter.date(from: currentTime)! < dateFormatter.date(from: time)! {
                availableResults.updateValue(trip as Any, forKey: time)
            }
        }
        let sorted = availableResults.sorted { $0.key < $1.key }
       // let timeArraySorted = Array(sorted.map({ $0.key }))
        let tripArraySorted = Array(sorted.map({ $0.value }))
        nearestTrip = tripArraySorted[0] as! String
        print(nearestTrip)
        firebaseClient.getTimes(by: nearestTrip, completion: getArrivalTime)
        tableView.reloadData() 
    }
    
    func getArrivalTime(trainTimes : [Time]){
        for trainTime in trainTimes {
            let time = trainTime.time
            let station = trainTime.stationID
            if station == destinationID {
                arrivalTime = time
                print(arrivalTime ?? "")
            }
        }
    }

    @IBAction func backToStationScreen(_ sender: Any) {
        let coordinator = TrainListCoordinator(navigationController: navigationController)
        coordinator.dismissTrainScreen()
    }
}

