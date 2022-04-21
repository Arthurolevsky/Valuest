//
//  BannerModel.swift
//  Valuest
//
//  Created by Arthur Olevsky on 16.03.2022.
//

import Foundation
import SwiftUI

struct BannerData {
    var title: String
    var message: String
    var type: BannerType
}

enum BannerType {
    case Warning
    case Regular
    case Success
    case Error
    
    var tintColor: Color {
        switch self {
            case .Error:
                return Color.red
            case .Regular:
                return Color.blue
            case .Success:
                return Color.green
            case .Warning:
                return Color.yellow
        }
    }
}

enum BannerEdge {
    case top, bottom
}
