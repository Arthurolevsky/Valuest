//
//  LoginButton.swift
//  Valuest
//
//  Created by Arthur Olevsky on 30.04.2022.
//

import SwiftUI

struct LoginButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Login")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color("textWhite"))
                .frame(maxWidth: .infinity)
                .frame(height: 52, alignment: .center)
                .background(Color("PrimaryButton"))
                .cornerRadius(10)
            
        }
    }
}
