//
//  StationCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 02/02/2022.
//

import UIKit
class StationCoordinator : Coordinator{
    let navigationController : UINavigationController?
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    var status : Bool = true
    var childCoordinators : [Coordinator] = []
    
    func start(){
        showStationScreen()
    }
     
    func showStationScreen(){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        stationViewController.isFromTo = status
        self.navigationController?.pushViewController(stationViewController, animated: true)
    }
    
    func dismissStationScreen(){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
    }
    
    func showTrainList(departure : String, destination : String, fromStationID : String, toStationID : String){
        let coordinator = TrainListCoordinator(navigationController: navigationController)
        coordinator.assignNames(from: departure, to: destination)
        coordinator.getStationsID(departureID: fromStationID, destinationID: toStationID)
        coordinator.start()
    }
}

