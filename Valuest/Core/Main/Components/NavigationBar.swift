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
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                withAnimation {
                    sideMenu.showLeftSideMenu.toggle()
                }
            } label: {
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
            
            Spacer()
        }
        .overlay(Text(viewRouter.selectedScreen.rawValue)
            .font(.headline.weight(.semibold)))
        .padding(.horizontal)
        .padding(.bottom, 6)
        .frame(width: getRect().width)
    }
}
