//
//  DismissAuthButton.swift
//  Valuest
//
//  Created by Arthur Olevsky on 30.04.2022.
//

import SwiftUI

struct DismissAuthButton: View {
    
    var dismiss: DismissAction
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(Color("Background"))
                        .frame(width: 34, height: 34, alignment: .center)
                    Image("XMark")
                }
            }
        }
        .padding(.top, 15)
        .padding(.horizontal, 8)
    }
}
