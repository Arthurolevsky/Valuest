//
//  SessionService.swift
//  Valuest
//
//  Created by Arthur Olevsky on 25.03.2022.
//

import Foundation
import Combine
import FirebaseAuth

enum SessionState {
    case loggedIn
    case loggedOut
}


protocol Session {
    var state: SessionState { get }
    var user: User? { get }
    func logout()
}

final class SessionManager: ObservableObject, Session {

    @Published var state: SessionState = .loggedOut
    @Published var user: User?
    private var handler: AuthStateDidChangeListenerHandle?
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    var isFirstLaunch: Bool {
        guard let isFirstLaunch = UserDefaults.standard.object(forKey: "isFirstLaunch") as? Bool else {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            return true
        }
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            return true
        } else {
            return false
        }
    }
    
    init() {
        setupFirebaseHandler()
    }
    
}

extension SessionManager {
    
    func setupFirebaseHandler() {
        handler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            self.state = user == nil ? .loggedOut : .loggedIn
            if let user = user {
                UserDefaults.standard.set(user.uid, forKey: "uid")
                user.getIDToken { token, error in
                    guard let token = token else {
                        return
                    }
                    UserDefaults.standard.set(token, forKey: "token")
                }
            }
        }
    }
}
