//
//  EmailField.swift
//  Valuest
//
//  Created by Arthur Olevsky on 23.03.2022.
//

import SwiftUI

struct EmailField: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var text: String
    @State var isEditing: Bool = false
    var isValid: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            switch colorScheme {
                case .light:
                    Image(isValid ? "emailLight" : "invalidEmail")
                case .dark:
                    Image(isValid ? "emailDark" : "invalidEmail")
                @unknown default:
                    Image(colorScheme == .light ? "emailLight" : "emailDark")
            }
            if #available(iOS 15.0, *) {
                TextField("Email", text: $text)
                    .font(.callout)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(Color("Text"))
            } else {
                TextField("Email", text: $text)
                    .font(.callout)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
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
