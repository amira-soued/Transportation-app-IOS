//
//  StationCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 02/02/2022.
//

import UIKit
import Model
class StationCoordinator : Coordinator{
    let navigationController : UINavigationController?
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    var status : Bool = true
    var recentSearch : Bool = false
    var recentDepartureStation : Station?
    var recentDestinationStation: Station?
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
        stationViewController.historySearch = recentSearch
        self.navigationController?.pushViewController(stationViewController, animated: true)
        stationViewController.searchedStartStation = recentDepartureStation
        stationViewController.searchedEndStation = recentDestinationStation
    }
    
    func dismissStationScreen(){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = true
    }
}

