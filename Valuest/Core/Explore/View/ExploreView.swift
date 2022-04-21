//
//  ExploreView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 09.03.2022.
//

import SwiftUI

struct ExploreView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Opp")
                Spacer()
                Text("HEY")
                Spacer()
                Text("Opp")
            }
        }
        .padding(.horizontal)
        .frame(width: getRect().width)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ExploreView()
                .environmentObject(SessionManager())
                .preferredColorScheme($0)
        }
    }
}
