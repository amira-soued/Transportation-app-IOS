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
    private let database = Firestore.firestore()
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
            }
        })
    }
    
    func checkImageUrlUpdate(completion: @escaping (Bool?) -> Void){
        database.collection("updates").document("imageUrl")
            .getDocument { (document, error) in
                guard let document = document, document.exists else{
                print("Error fetching document: \(error!)")
                return
              }
                guard let data = document.data() as? [String: Bool] else {
                print("Document data was empty.")
                return
              }
                for (_, value) in data{
                    let urlImageStatus = value
                    print("firebase image value: \(urlImageStatus)")
                    completion(urlImageStatus)
                }
            }
    }
    func resetImageUpdateStatus(){
        let updateStatus = database.collection("updates").document("imageUrl")
        updateStatus.updateData([
            "urlUpdate": false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}
