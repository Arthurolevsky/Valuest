//
//  ExploreViewModel.swift
//  Valuest
//
//  Created by Arthur Olevsky on 10.04.2022.
//

import Foundation
import SwiftUI

final class SideMenuViewModel: ObservableObject {
    
    @Published var showLeftSideMenu: Bool = false
    @Published var offset: CGFloat = 0
    @Published var lastStoredOffset: CGFloat = 0
        
}
