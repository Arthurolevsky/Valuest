//
//  NavigationBar.swift
//  Valuest
//
//  Created by Arthur Olevsky on 13.04.2022.
//

import SwiftUI

struct NavigationBar: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var sideMenu: SideMenuViewModel
    @EnvironmentObject var session: SessionManager

    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewRouter.selectedScreen.rawValue)
                .font(.title.bold())
            
            Spacer()

            Button {
                if session.state == .loggedIn {
                    withAnimation(.linear(duration: 0.2)) {
                        sideMenu.showLeftSideMenu.toggle()
                    }
                } else {
                    viewRouter.showAuthFlow = true
                }
            } label: {
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
        .padding(.bottom, 6)
    }
}
