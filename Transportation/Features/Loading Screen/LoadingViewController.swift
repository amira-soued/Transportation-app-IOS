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
    let imageKey = "imageKey"
    let directionSousseKey = "directionSousseKey"
    let directionMahdiaKey = "directionMahdiaKey"
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.type = .ballClipRotatePulse
        loadingIndicatorView.color = .black
        loadingIndicatorView.startAnimating()
        loadAllStations()
        loadDirectionMahdiaTrips()
        loadDirectionSousseTrips()
        loadImageUrl()
    
        loadingImageView.setImage(url: Current.imageUrlString, placeholder: "metro")
        dispatchGroup.notify(queue: .main) {
            self.didFinishLoadingData()
        }
    }
}

private extension LoadingViewController {

    func loadImageUrl(){
        if let urlString = UserDefaults.standard.string(forKey: self.imageKey){
            Current.imageUrlString = urlString
            print("image url\(Current.imageUrlString)")
            remoteConfig.checkImageUrlUpdate { updateStatus in
                if updateStatus == false{
                    return
                }
            }
        }
        dispatchGroup.enter()
        remoteConfig.fetchLoadingImageUrl { stringURL in
            UserDefaults.standard.set(stringURL, forKey: self.imageKey)
            Current.imageUrlString = UserDefaults.standard.string(forKey: self.imageKey) ?? ""
            self.dispatchGroup.leave()
        }
        remoteConfig.checkImageUrlUpdate { updateStatus in
            if updateStatus == true{
                self.remoteConfig.resetImageUpdateStatus()
            }
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
    
    func loadDirectionSousseTrips(){
        if let tripsToSousseData = UserDefaults.standard.object(forKey: self.directionSousseKey) as? Data {
            let decoder = JSONDecoder()
            if let tripsToSousse = try? decoder.decode([TripsByStation].self, from: tripsToSousseData) {
                Current.directionSousseTrips = tripsToSousse
                print("current\(Current.directionSousseTrips)")
            }
            return
        }
        dispatchGroup.enter()
        firebaseClient.getDirectionSousseTrips { tripsByStation in
            Current.directionSousseTrips = tripsByStation
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(tripsByStation)
                UserDefaults.standard.set(data, forKey: self.directionSousseKey)
                print("current\(Current.directionSousseTrips)")
            } catch {
                print("Unable to Encode (\(error))")
            }
            self.dispatchGroup.leave()
        }
    }
    
    func loadDirectionMahdiaTrips(){
        if let tripsToMahdiaData = UserDefaults.standard.object(forKey: self.directionMahdiaKey) as? Data {
            let decoder = JSONDecoder()
            if let tripsToMahdia = try? decoder.decode([TripsByStation].self, from: tripsToMahdiaData) {
                Current.directionMahdiaTrips = tripsToMahdia
            }
            return
        }
        dispatchGroup.enter()
        firebaseClient.getDirectionMahdiaTrips { tripsByStation in
            Current.directionMahdiaTrips = tripsByStation
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(tripsByStation)
                UserDefaults.standard.set(data, forKey: self.directionMahdiaKey)
                print("current\(Current.directionMahdiaTrips)")
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
