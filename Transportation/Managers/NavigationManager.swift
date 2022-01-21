//
//  NavigationManager.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit
class NavigationManager{
    let window : UIWindow?
    var mainScreenCoordinator: MainScreenCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start(){
        showMainScreen()
    }
    
    func showMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
        mainScreenCoordinator = MainScreenCoordinator(window: window)
        vc.mainScreenCoordinator = mainScreenCoordinator
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
    }
}
