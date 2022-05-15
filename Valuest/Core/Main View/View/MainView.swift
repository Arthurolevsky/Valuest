//
//  MainView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 05.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionManager
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var sideMenu: SideMenuViewModel = SideMenuViewModel()
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 60
        
        ZStack {
            
            Color.background
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                
                MainMenu(showMenu: $sideMenu.showLeftSideMenu)
                    .environmentObject(session)
                
                VStack(spacing: 0) {
                    
                    switch viewRouter.selectedScreen {
                        case .explore:
                            ExploreView()
                                .environmentObject(viewRouter)
                                .environmentObject(sideMenu)
                                .environmentObject(session)
                        case .research:
                            ResearchView()
                        case .portfolios:
                            PortfoliosView()
                    }
                    
                    TabBar(viewRouter: viewRouter)
                        .frame(width: getRect().width)
                }
                .overlay(
                    Rectangle()
                        .fill(
                            Color.primary
                                .opacity(Double((sideMenu.offset / sideBarWidth) / 15))
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2)) {
                                sideMenu.showLeftSideMenu.toggle()

                            }
                        }
                )
            }
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: sideMenu.offset > 0 ? sideMenu.offset : 0)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(isPresented: $viewRouter.showAuthFlow, content: {
            AuthView()
                .environmentObject(session)
        })
        .animation(.linear(duration: 0.2), value: sideMenu.offset == 0)
        .onChange(of: sideMenu.showLeftSideMenu) { newValue in
            
            if sideMenu.showLeftSideMenu && sideMenu.offset == 0 {
                sideMenu.offset = sideBarWidth
                sideMenu.lastStoredOffset = sideMenu.offset
            }
            
            if !sideMenu.showLeftSideMenu && sideMenu.offset == sideBarWidth {
                sideMenu.offset = 0
                sideMenu.lastStoredOffset = 0
            }
        }
        .onChange(of: session.state) { state in
            if state == .loggedOut {
                sideMenu.showLeftSideMenu = false
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MainView()
                .environmentObject(SessionManager())
                .preferredColorScheme($0)
        }
    }
}
