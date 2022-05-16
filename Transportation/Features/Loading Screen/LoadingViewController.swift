//
//  LoadingViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 22/04/2022.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAnalytics

class LoadingViewController: UIViewController {
    let firebaseClient = FirebaseClient.shared
    let remoteConfig = RemoteConfigure()
    let stationKey = "stationKey"
    let timeByTripKey = "timeByTripKey"
    let tripByStationKey = "trpByStationKey"
    let imageKey = "imageKey"
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicatorView.type = .ballClipRotatePulse
        loadingIndicatorView.color = .black
        loadingIndicatorView.startAnimating()
        loadAllStations()
        loadAllTimesByTrip()
        loadAllTripsByStation()
        loadImageUrl()
        loadingImageView.setImage(url: Current.imageUrlString, placeholder: "metro")
        print(Current.imageUrlString)
        dispatchGroup.notify(queue: .main) {
            self.didFinishLoadingData()
        }
//
//        remoteConfig.fetchLoadingImageUrl { stringURL in
//            print(stringURL)
//            self.imageUrl = stringURL
//        }
    }
}

private extension LoadingViewController {

    func loadImageUrl(){
        if let urlString = UserDefaults.standard.string(forKey: imageKey){
            Current.imageUrlString = urlString
            print(Current.imageUrlString)
        }
        dispatchGroup.enter()
        remoteConfig.fetchLoadingImageUrl { stringURL in
//            print(stringURL)
//            Current.imageUrlString = stringURL
            UserDefaults.standard.set(stringURL, forKey: self.imageKey)
            self.dispatchGroup.leave()
        }
       
    }
    
    func loadAllStations() {
        if let stationsData = UserDefaults.standard.object(forKey: stationKey)  as? Data {
            let decoder = JSONDecoder()
            if let stations = try? decoder.decode([Station].self, from: stationsData) {
                Current.stations = stations
            }
            return
        }
        dispatchGroup.enter()
        firebaseClient.getStations{ stations in
            Current.stations = stations
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(stations)
                UserDefaults.standard.set(data, forKey: self.stationKey)
            } catch {
                print("Unable to Encode (\(error))")
            }
            self.dispatchGroup.leave()
        }
    }
    
    func loadAllTimesByTrip() {
        if let timeByTripsData = UserDefaults.standard.object(forKey: timeByTripKey) as? Data{
            let decoder = JSONDecoder()
            if let timeByTrips = try? decoder.decode([TimeByTrip].self, from: timeByTripsData) {
                Current.timeByTrips = timeByTrips
            }
            return
        }
        dispatchGroup.enter()
        firebaseClient.getTimeByTrip { timeByTrips in
            Current.timeByTrips = timeByTrips
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(timeByTrips)
                UserDefaults.standard.set(data, forKey: self.timeByTripKey)
            } catch {
                print("Unable to Encode (\(error))")
            }
            self.dispatchGroup.leave()
        }
    }
    
    func loadAllTripsByStation() {
        if let tripByStationsData = UserDefaults.standard.object(forKey: tripByStationKey) as? Data {
            let decoder = JSONDecoder()
            if let tripByStations = try? decoder.decode([TripByStations].self, from: tripByStationsData) {
                Current.tripByStations = tripByStations
            }
            return        }
        dispatchGroup.enter()
        firebaseClient.getTripByStation{ tripByStations in
            Current.tripByStations = tripByStations
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(tripByStations)
                UserDefaults.standard.set(data, forKey: self.tripByStationKey)
            } catch {
                print("Unable to Encode (\(error))")
            }
            self.dispatchGroup.leave()
        }
    }
  
    func didFinishLoadingData() {
        loadingIndicatorView.stopAnimating()
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: self.navigationController!)
        mainScreenCoordinator.start()
    }
}
