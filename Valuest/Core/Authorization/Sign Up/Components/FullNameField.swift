//
//  FullNameField.swift
//  Valuest
//
//  Created by Arthur Olevsky on 23.03.2022.
//

import SwiftUI

struct FullNameField: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(colorScheme == .light ? "userLight" : "userDark")
            if #available(iOS 15.0, *) {
                TextField("Full name", text: $text)
                    .font(.callout)
                    .textContentType(.givenName)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Color("Text"))
            } else {
                TextField("Full name", text: $text)
                    .font(.callout)
                    .textContentType(.givenName)
                    .autocapitalization(.none)
                    .foregroundColor(Color("Text"))
            }
        }
        .padding(.horizontal)
        .frame(height: 48, alignment: .center)
        .background(Color("FieldBG"))
        .cornerRadius(10)
    }
}

