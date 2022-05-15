//
//  RegistrationButton.swift
//  Valuest
//
//  Created by Arthur Olevsky on 30.04.2022.
//

import SwiftUI

struct RegistrationButton: View {
    
    var isValid: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Create free account")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color("textWhite"))
                .frame(maxWidth: .infinity)
                .frame(height: 48, alignment: .center)
                .background(isValid ? Color.gray :  Color("PrimaryButton"))
                .cornerRadius(10)
            
        }
        .disabled(isValid)
    }
}
