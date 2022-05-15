//
//  AuthView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 24.04.2022.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            if session.isFirstLaunch {
                RegistrationView(dismiss: dismiss)
                    .environmentObject(session)
            } else {
                LoginView(dismiss: dismiss)
                    .environmentObject(session)
            }
        }
        .onChange(of: session.state) { state in
            if state == .loggedIn {
                dismiss()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(SessionManager())
    }
}
