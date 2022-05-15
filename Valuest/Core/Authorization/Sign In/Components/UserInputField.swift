//
//  UserInputField.swift
//  Valuest
//
//  Created by Arthur Olevsky on 20.03.2022.
//

import SwiftUI

struct UserInputField: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var text: String
    @State private var isHidden: Bool = true
    var placeHolder: String
    var primaryImageLight: String
    var primaryImageDark: String
    var isPassword: Bool
    var showForgotPassword: Bool
    
    var body: some View {
        if isPassword {
            VStack(spacing: 10) {
                HStack(alignment: .center, spacing: 16) {
                    Image(colorScheme == .light ? primaryImageLight : primaryImageDark)
                    if isHidden {
                        if #available(iOS 15.0, *) {
                            SecureField(placeHolder, text: $text)
                                .font(.callout)
                                .textInputAutocapitalization(.never)
                                .textContentType(.password)
                                .foregroundColor(Color("Text"))
                        } else {
                            SecureField(placeHolder, text: $text)
                                .font(.callout)
                                .autocapitalization(.none)
                                .textContentType(.password)
                                .foregroundColor(Color("Text"))
                        }
                    } else {
                        if #available(iOS 15.0, *) {
                            TextField(placeHolder, text: $text)
                                .font(.callout)
                                .textInputAutocapitalization(.never)
                                .textContentType(.password)
                                .foregroundColor(Color("Text"))
                        } else {
                            TextField(placeHolder, text: $text)
                                .font(.callout)
                                .autocapitalization(.none)
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
                if showForgotPassword {
                    HStack {
                        Spacer()
                        NavigationLink {
                            ResetPasswordView()
                        } label: {
                            Text("Forgot password")
                                .font(.footnote)
//                                .fontWeight(.semibold)
                        }
                    }
                } else {
                    Text("Your password must be 8 or more characters long & contain a mix of upper and lower case letters, numbers and symbols")
//                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .font(.caption)
                }
            }
        } else {
            HStack(alignment: .center, spacing: 16) {
                Image(colorScheme == .light ? primaryImageLight : primaryImageDark)
                if #available(iOS 15.0, *) {
                    TextField(placeHolder, text: $text)
                        .font(.callout)
                        .textContentType(.givenName)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(Color("Text"))
                } else {
                    TextField(placeHolder, text: $text)
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
}

//struct UserInputField_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInputField()
//    }
//}
