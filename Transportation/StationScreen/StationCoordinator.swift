//
//  StationCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 02/02/2022.
//

import UIKit
class StationCoordinator {
    let navigationController : UINavigationController?
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(buttonClicked : UIButton, whichButton : UIButton){
        showStationScreen(button: buttonClicked, toButton: whichButton)
    }
     
    func showStationScreen(button : UIButton, toButton : UIButton){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        stationViewController.isFromTo = (button == toButton)
        self.navigationController!.pushViewController(stationViewController, animated: true)
    }
}
