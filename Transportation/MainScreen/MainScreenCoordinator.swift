//
//  MainScreenCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 12/01/2022.
//

import UIKit
class MainScreenCoordinator{
    let window : UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
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
        window?.rootViewController?.present(stationViewController, animated: true)
    }
}
