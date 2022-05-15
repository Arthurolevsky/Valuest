//
//  ValuestApp.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI
import Firebase

@main
struct ValuestApp: App {
    
    @StateObject var session = SessionManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .environmentObject(session)
            }
        }
    }
}
