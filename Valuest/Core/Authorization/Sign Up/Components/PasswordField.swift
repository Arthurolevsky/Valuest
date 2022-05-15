//
//  PasswordField.swift
//  Valuest
//
//  Created by Arthur Olevsky on 23.03.2022.
//

import SwiftUI

struct PasswordField: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var text: String
    @State private var isHidden: Bool = true
    var isValid: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 16) {
                switch colorScheme {
                    case .light:
                        Image(isValid ? "lockLight": "invalidPassword")
                    case .dark:
                        Image(isValid ? "lockDark": "invalidPassword")
                    @unknown default:
                        Image(colorScheme == .light ? "lockLight" : "lockDark")
                }
                if isHidden {
                    if #available(iOS 15.0, *) {
                        SecureField("Password", text: $text)
                            .font(.callout)
                            .textContentType(.password)
                            .foregroundColor(Color("Text"))
                            
                    } else {
                        SecureField("Password", text: $text)
                            .font(.callout)
                            .textContentType(.password)
                            .foregroundColor(Color("Text"))
                            
                    }
                } else {
                    if #available(iOS 15.0, *) {
                        TextField("Password", text: $text)
                            .font(.callout)
                            .textContentType(.password)
                            .foregroundColor(Color("Text"))
                            
                    } else {
                        TextField("Password", text: $text)
                            .font(.callout)
                            .textContentType(.password)
                            .foregroundColor(Color("Text"))
                    }
                }
                Spacer()
                Button {
                    if isHidden {
                        isHidden = false
                    } else {
                        isHidden = true
                    }
                } label: {
                    if colorScheme == .light {
                        Image(isHidden ? "showEyeLight" : "hideEyeLight")
                    } else {
                        Image(isHidden ? "showEyeDark" : "hideEyeDark")
                    }
                }
                .frame(width: 22, alignment: .center)
            }
            .padding(.horizontal)
            .frame(height: 48, alignment: .center)
            .background(Color("FieldBG"))
            .cornerRadius(10)
            
            Text("Your password must be 8 or more characters long & contain a mix of upper and lower case letters, numbers and symbols")
                .foregroundColor(!isValid ? .red : Color("Text"))
                .lineLimit(2)
                .font(.caption)
            
        }
    }
}

