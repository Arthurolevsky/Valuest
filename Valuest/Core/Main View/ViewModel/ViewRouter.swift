//
//  ViewRouter.swift
//  Valuest
//
//  Created by Arthur Olevsky on 05.04.2022.
//

import Foundation

enum Screens: String {
    case explore = "Explore"
    case portfolios = "Portfolios"
    case research = "Research"
}

final class ViewRouter: ObservableObject {
    
    @Published var selectedScreen: Screens = .explore
    @Published var showAuthFlow: Bool = false
    
    /// Function changes selectedScreen variable, therefore it changes shown screen.
    /// - Parameter screen: Screen that we want to show user
    func change(to screen: Screens) {
        self.selectedScreen = screen
    }
    
}
