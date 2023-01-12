//
//  OnboardModel.swift
//  IGTracker
//
//  Created by Юлия Алдохина on 28/09/22.
//

import Foundation
import UIKit

enum Onboarding: Int, CaseIterable {
    case first = 1
    case second
    case third


    var image: UIImage? {
        return UIImage(named: "slide\(self.rawValue)")
    }
    
    var title: String {
        switch self {
        case .first:
            return "Track your Followers".localized()
        case .second:
            return "Users blocking me".localized()
        case .third:
            return "Audience insights".localized()

        }
    }
    
    var subTitle: String {
        switch self {
        case .first:
            return "See all story viewers,even after\n 24 hours".localized()
        case .second:
            return "Find the accounts that have\n blocked".localized()
        case .third:
            return "Discover the followers you have\n gained and lost".localized()

        }
    }
}
