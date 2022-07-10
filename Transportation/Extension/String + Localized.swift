//
//  String + Localized.swift
//  Transportation
//
//  Created by Souid, Houcem on 10/07/2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
