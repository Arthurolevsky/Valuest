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
                switch session.state {
                    case .loggedIn:
                        MainView()
                            .environmentObject(session)
                    case .loggedOut:
                        if session.isFirstLaunch {
                            SignUpView()
                        } else {
                            SignInView()

                        }
                }
            }
        }
    }
}
