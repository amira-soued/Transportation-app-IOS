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
    
    func start(buttonClicked : UIButton, toButton : UIButton){
        showStationScreen(button: buttonClicked, whichButton: toButton)
    }
     
    func showStationScreen(button : UIButton, whichButton : UIButton){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        stationViewController.isFromTo = (button == whichButton)
        window?.rootViewController?.present(stationViewController, animated: true)
    }
}
