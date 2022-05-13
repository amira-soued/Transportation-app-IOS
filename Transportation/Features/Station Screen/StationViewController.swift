//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit
//import FirebaseFirestore

enum Cell {
    case stationCell(Station)
    case searchResult(start: Date, end: Date)
}

class StationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    var cells: [Cell] = []
 
    var isFromTo: Bool = true
    var historySearch : Bool = false
    let firebaseClient = FirebaseClient.shared
    var historyManager = HistoryManager()
    var startStation: Station?
    var endStation: Station?
    var searchedStartStation : Station?
    var searchedEndStation : Station?
    
    let allStationsArray: [Station] = Current.stations
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupHistorySearch()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
    
    @IBAction func textFieldTyping(_ sender: UITextField) {
        let searchText  = sender.text ?? ""
        cells = allStationsArray.compactMap { station in
            if station.name.range(of: searchText, options: .caseInsensitive) != nil {
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
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        startTextField.delegate = self
        endTextField.delegate = self
        stationScreenStackView.layer.cornerRadius = 10
        if isFromTo{
            endTextField.becomeFirstResponder()
        } else {
            startTextField.becomeFirstResponder()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "stationTableViewCell")
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
    }
    
    func setupHistorySearch() {
        guard historySearch else {
            return
        }
        startStation = searchedStartStation
        endStation = searchedEndStation
        startTextField.text = startStation?.name
        startTextField.resignFirstResponder()
        endTextField.text = endStation?.name
        endTextField.resignFirstResponder()
        getAllAvailableTrips()
    }
    
    func getPossibleTrips(with date: Date, from trips: [Trip]) -> [Trip] {
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
        startTextField.text = station.name
        startStation = station
        if endStation == nil {
            endTextField.becomeFirstResponder()
        }
    }

    func setEndStation(_ station: Station) {
        endTextField.text = station.name
        endStation = station
        if startStation == nil {
            startTextField.becomeFirstResponder()
        }
    }

    func getAllAvailableTrips() {
        cells.removeAll()
        guard let startStation = startStation, let endStation = endStation else { return }
        var tripResults = [Trip]()
        let trip = RecentTrip(start: startStation, finish:endStation)
        historyManager.addTrip(searchedTrip: trip)
        for trip in Current.tripByStations {
            if trip.id == startStation.Id {
                tripResults = trip.trips
            }
        }
        let sortedTrips = tripResults.sorted {
            $0.tripTime < $1.tripTime
        }
        let startDate = Date()
        let nearestTrips = getPossibleTrips(with: startDate, from: sortedTrips)
        for eachTrip in nearestTrips {
            var timeResults = [Time]()
            for time in Current.timeByTrips{
                if eachTrip.tripId == time.tripId{
                    timeResults = time.times
                }
            }
            let endTimeIndex = timeResults.firstIndex { time in
                time.stationId == endStation.Id
            }
            if let index = endTimeIndex {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                if let endDate = dateFormatter.date(from: timeResults[index].time),
                   let nearestTripDate = dateFormatter.date(from: eachTrip.tripTime) {
                    let cell = Cell.searchResult(start: nearestTripDate, end: endDate)
                    cells.append(cell)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "stationTableViewCell", for: indexPath) as! StationTableViewCell
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
            if startTextField.isFirstResponder {
                setStartStation(station)
            } else {
                setEndStation(station)
            }
          getAllAvailableTrips()
        case .searchResult:
            break
        }
        tableView.reloadData()
    }
}
