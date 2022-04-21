//
//  TabBar.swift
//  Valuest
//
//  Created by Arthur Olevsky on 12.04.2022.
//

import SwiftUI

struct TabBar: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack(alignment: .center, spacing: 34) {
            
            Spacer()
            
            VStack(alignment: .center, spacing: 7) {
                if viewRouter.selectedScreen == .explore {
                    Image(colorScheme == .light ? "ExploreSelectedLight" : "ExploreSelectedDark")
                    Text("Explore")
                        .foregroundColor(viewRouter.selectedScreen == .explore ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                } else {
                    Image(colorScheme == .light ? "ExploreUnselectedLight" : "ExploreUnselectedDark")
                    Text("Explore")
                        .foregroundColor(viewRouter.selectedScreen == .explore ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                }
            }
            .onTapGesture {
                viewRouter.selectedScreen = .explore
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 7) {
                if viewRouter.selectedScreen == .portfolios {
                    Image(colorScheme == .light ? "PortfolioSelectedLight" : "PortfolioSelectedDark")
                    Text("Portfolios")
                        .foregroundColor(viewRouter.selectedScreen == .portfolios ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                } else {
                    Image(colorScheme == .light ? "PortfolioUnselectedLight" : "PortfolioUnselectedDark")
                    Text("Portfolios")
                        .foregroundColor(viewRouter.selectedScreen == .portfolios ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                }
            }
            .onTapGesture {
                viewRouter.selectedScreen = .portfolios
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 7) {
                if viewRouter.selectedScreen == .research {
                    Image(colorScheme == .light ? "ResearchSelectedLight" : "ResearchSelectedDark")
                    Text("Research")
                        .foregroundColor(viewRouter.selectedScreen == .research ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                } else {
                    Image(colorScheme == .light ? "ResearchUnselectedLight" : "ResearchUnselectedDark")
                    Text("Research")
                        .foregroundColor(viewRouter.selectedScreen == .research ? Color("Text") : Color("UnselectedTab"))
                        .font(.caption2)
                }
            }
            .onTapGesture {
                viewRouter.selectedScreen = .research
            }
            
            Spacer()
        }
        .background(Color.clear)
        .padding(.top, 8)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(viewRouter: ViewRouter())
    }
}
