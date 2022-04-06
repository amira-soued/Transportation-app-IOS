//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit
import FirebaseFirestore

enum Cell {
    case stationCell(Station)
    case searchResult(start: Date, end: Date)
}

class StationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    var cells: [Cell] = []
 
    var isFromTo: Bool = true
    var firebaseClient = FirebaseClient()
    var startStation: Station?
    var endStation: Station?

    /// Represents all the stations recieved by the Backend
    var allStationsArray = [Station]()

    override func viewDidLoad() { 
        super.viewDidLoad()
        stationScreenStackView.layer.cornerRadius = 10
        if isFromTo{
            toTextField.becomeFirstResponder()
        } else {
            fromTextField.becomeFirstResponder()
        }
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.isHidden = true
        tableView.register(UINib(nibName: "stationTableViewCell", bundle: nil), forCellReuseIdentifier: "stationTableViewCell")
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        fromTextField.delegate = self
        toTextField.delegate = self
        loadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
    
    @IBAction func textFieldTyping(_ sender: UITextField) {
        let searchText  = sender.text ?? ""
        tableView.isHidden = false
        cells = allStationsArray.compactMap { station in
            if station.name?.range(of: searchText, options: .caseInsensitive) != nil {
                return .stationCell(station)
            }
            return nil
        }
        tableView.reloadData()
    }
  
    @IBAction func backToMainScreen(_ sender: Any) {
        let coordinator = StationCoordinator(navigationController: navigationController)
        coordinator.dismissStationScreen()
    }
}

extension StationViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset > 111 {
            return
        }
        if offset <= 0 {
            headerViewTopConstraint.constant = 0
        }
        headerViewTopConstraint.constant = -offset
    }
}

private extension StationViewController {
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStationsArray = stations
            self.cells.removeAll()
            for station in self.allStationsArray {
                self.cells.append(.stationCell(station))
            }
            self.tableView.reloadData()
        }
    }

    func getNearestTrip(with date: Date, from trips: [Trip]) -> [Trip] {
        let dateFormatter = DateFormatter()
        var availableTrips = [Trip]()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        for trip in trips {
            if trip.tripTime > timeString {
                availableTrips.append(trip)
            }
        }
        return availableTrips
    }

    func setStartStation(_ station: Station) {
        fromTextField.text = station.name
        startStation = station
        if endStation == nil {
            toTextField.becomeFirstResponder()
            textFieldTyping(toTextField)
        }
    }

    func setEndStation(_ station: Station) {
        toTextField.text = station.name
        endStation = station
        if startStation == nil {
            fromTextField.becomeFirstResponder()
            textFieldTyping(fromTextField)
        }
    }

    func getRecentSearchedTrips() {
        cells.removeAll(keepingCapacity: false)
        guard let startStation = startStation, let endStation = endStation else { return }
        firebaseClient.getTrips(stationID: startStation.ID ?? "") { result in
            let startDate = Date()
            let nearestTrip = self.getNearestTrip(with: startDate, from: result)
             for eachTrip in nearestTrip {
                self.firebaseClient.getTimes(by: eachTrip.tripID) { times in
                    let endTimeIndex = times.firstIndex { time in
                        time.stationID == endStation.ID
                    }
                    if let index = endTimeIndex {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        if let endDate = dateFormatter.date(from: times[index].time),
                           let nearestTripDate = dateFormatter.date(from: eachTrip.tripTime) {
                            let cell = Cell.searchResult(start: nearestTripDate, end: endDate)
                            self.cells.append(cell)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension StationViewController : UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        switch cellType {
        case .stationCell(let station) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "stationTableViewCell", for: indexPath) as! stationTableViewCell
            cell.setCell(stationName: station.name, cityName: station.city)
            return cell
        case .searchResult(let startTime, let endTime):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
            cell.setupCell(startTime: startTime, endTime: endTime)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = cells[indexPath.row]
        switch cellType {
        case .stationCell(let station):
            if fromTextField.isFirstResponder {
                setStartStation(station)
            } else {
                setEndStation(station)
            }
            getRecentSearchedTrips()
        case .searchResult:
            break
        }
        tableView.reloadData()
    }
}
