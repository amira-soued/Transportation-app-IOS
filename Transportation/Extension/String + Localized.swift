//
//  String + Localized.swift
//  Transportation
//


import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
