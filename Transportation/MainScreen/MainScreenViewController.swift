//
//  MainScreenViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit

class MainScreenViewController: UIViewController {
  
    @IBOutlet weak var homeScreenStackView: UIStackView!
    @IBOutlet weak var FromButton: UIButton!
    @IBOutlet weak var ToButton: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
          
        homeScreenStackView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

   
    @IBAction func fromButtonClicked(_ sender: Any) {
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
         trainViewController.modalPresentationStyle = .fullScreen
         present(trainViewController, animated: true)
    }
    
    @IBAction func toButtonClicked(_ sender: Any) {
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
         trainViewController.modalPresentationStyle = .fullScreen
         present(trainViewController, animated: true)
    }
}
