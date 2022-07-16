//
//  SceneDelegate.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    var navigationManager: NavigationManager?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure()
        navigationManager = NavigationManager(window: window, navigationController: navigationController)
        navigationManager?.start()
        window?.makeKeyAndVisible()
    }

    var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

