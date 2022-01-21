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
    
    func start(){
        showStationScreen()
    }
    
    func showStationScreen(){
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
         trainViewController.modalPresentationStyle = .fullScreen
   
        window?.rootViewController?.present(trainViewController, animated: true)
    }
}
