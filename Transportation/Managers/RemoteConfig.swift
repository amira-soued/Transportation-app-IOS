//
//  RemoteConfig.swift
//  Transportation
//
//  Created by MacBook Pro on 16/05/2022.
//

import Foundation
import UIKit
import FirebaseAnalytics
import Firebase

class RemoteConfigure{
    private let remoteConfigure = RemoteConfig.remoteConfig()
    
      // fetch the url saved in remote config
    func fetchLoadingImageUrl(completion: @escaping (String?) -> Void){
        self.remoteConfigure.fetch(withExpirationDuration: 0, completionHandler: { status , error in
            if status == .success, error == nil {
                self.remoteConfigure.activate { _ , error in
                    guard error == nil else {
                        return
                    }
                    let remoteConfigValue = self.remoteConfigure.configValue(forKey: "urlString").stringValue ?? ""
                    completion(remoteConfigValue)
                }
            } else {
                print("Error fetching url")
//                completion("")
            }
        })
    }
}
