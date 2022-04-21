//
//  PortfoliosView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 05.04.2022.
//

import SwiftUI

struct PortfoliosView: View {
    var body: some View {
        ScrollView {
            Text("Portfolios")
        }
        .padding(.horizontal)
        .frame(width: getRect().width)
    }
}

struct PortfoliosView_Previews: PreviewProvider {
    static var previews: some View {
        PortfoliosView()
    }
}
