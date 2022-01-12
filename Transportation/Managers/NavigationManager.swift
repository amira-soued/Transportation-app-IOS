//
//  NavigationManager.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import Foundation
import UIKit
class NavigationManager{
    let window : UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    
    func start(){
        showMainScreen()
    }
    
    func showMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
    }
}
