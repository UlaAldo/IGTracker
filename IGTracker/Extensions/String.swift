//
//  String.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 07/09/22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
