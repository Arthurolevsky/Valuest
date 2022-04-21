//
//  ResearchView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 05.04.2022.
//

import SwiftUI

struct ResearchView: View {
    var body: some View {
        ScrollView {
            
            Text("Research")
        }
        .padding(.horizontal)
        .frame(width: getRect().width)
    }
}

struct ResearchView_Previews: PreviewProvider {
    static var previews: some View {
        ResearchView()
    }
}
