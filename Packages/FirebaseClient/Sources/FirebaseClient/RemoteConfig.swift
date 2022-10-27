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

public class RemoteConfigClient {
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let database = Firestore.firestore()

    public static let shared = RemoteConfigClient()

      // fetch the url saved in remote config
    public func fetchLoadingImageUrl(completion: @escaping (String?) -> Void){
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status , error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _ , error in
                    guard error == nil else {
                        return
                    }
                    let url = self.remoteConfig.configValue(forKey: "urlString").stringValue ?? ""
                    completion(url)
                }
            } else {
                print("Error fetching url")
            }
        })
    }
    
    public func checkImageUrlUpdate(completion: @escaping (Bool?) -> Void){
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
    
    public func resetImageUpdateStatus(){
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
