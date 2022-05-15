//
//  SignInView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionManager
    @StateObject var login: LoginService = LoginService()
    var dismiss: DismissAction
    
    var body: some View {
        // MARK: Login View
        ZStack(alignment: .top) {
            // Background
            Color("Background")
                .ignoresSafeArea()
            

            //MARK: Login Content
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: Logo
                    Image("Logo_16x85")
                    
                    
                    VStack(alignment: .leading, spacing: 26) {
                        
                        // MARK: Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Log In")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("Don’t have an account?")
                                    .font(.callout)
                                HStack(spacing: 4) {
                                    NavigationLink {
                                        RegistrationView(dismiss: dismiss)
                                    } label: {
                                        Text("Sign up")
                                            .foregroundColor(.blue)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .font(.callout)
                            }
                        }
                        
                        // MARK: Login Credentials Input
                        VStack(alignment: .leading, spacing: 16) {
                            UserInputField(text: $login.loginCredentials.email, placeHolder: "Enter your email", primaryImageLight: "userLight", primaryImageDark: "userDark", isPassword: false, showForgotPassword: false)
                            UserInputField(text: $login.loginCredentials.password, placeHolder: "Enter your password", primaryImageLight: "lockLight", primaryImageDark: "lockDark", isPassword: true, showForgotPassword: true)
                            
                        }
                        
                        
                        // MARK: Login Button and Social Login Features
                        VStack(alignment: .center, spacing: 24) {
                            
                            LoginButton {
                                login.userLogin()
                            }
                            
                            Text("Or continue with social account")
                                .foregroundColor(Color("Text"))
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            VStack(spacing: 16) {
                                
                                ThirdPartyAuthButton(image: "facebook", text: "Continue with Facebook", textColor: "textWhite", background: "facebookBlue") {
                                    print("Facebook")
                                }
                                
                                ThirdPartyAuthButton(image: "google", text: "Continue with Google", textColor: "textDarkBlue", background: "DefaultWhite") {
                                    print("Google")
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("textDarkBlue"), lineWidth: 0.5))
                                
                                ThirdPartyAuthButton(image: "apple", text: "Continue with Apple", textColor: "textWhite", background: "DefaultBlack") {
                                    print("Apple")
                                }
                            }
                        }
                    }
                    .foregroundColor(Color("Text"))
                }
                .padding(.top, 24)
            }
            .padding(.horizontal, 16)

            // MARK: Dismiss Button
            DismissAuthButton(dismiss: dismiss)
            
        }
        .navigationBarHidden(true)
        .banner(data: $login.bannerData, show: $login.showBanner)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}
