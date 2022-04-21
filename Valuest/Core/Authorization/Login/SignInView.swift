//
//  SignInView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var login: LoginService = LoginService()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    Image("Logox16")
                    
                    VStack(alignment: .leading, spacing: 26) {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Log In")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("Don’t have an account?")
                                    .font(.callout)
                                HStack(spacing: 4) {
                                    NavigationLink {
                                        SignUpView()
                                    } label: {
                                        Text("Sign up")
                                            .foregroundColor(.blue)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .font(.callout)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            UserInputField(text: $login.loginCredentials.email, placeHolder: "Enter your email", primaryImageLight: "userLight", primaryImageDark: "userDark", isPassword: false, showForgotPassword: false)
                            UserInputField(text: $login.loginCredentials.password, placeHolder: "Enter your password", primaryImageLight: "lockLight", primaryImageDark: "lockDark", isPassword: true, showForgotPassword: true)
                            
                        }
                        
                        
                        
                        VStack(alignment: .center, spacing: 24) {
                            
                            Button {
                                login.userLogin()
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
                            
                            Text("Or continue with social account")
                                .foregroundColor(Color("Text"))
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            VStack(spacing: 16) {
                                
                                Button {
                                    
                                } label: {
                                    
                                    HStack(alignment: .center, spacing: 10) {
                                        
                                        Image("facebook")
                                        Text("Continue with Facebook")
                                            .foregroundColor(Color("textWhite"))
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                        
                                    }
                                    .frame(height: 52)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("facebookBlue"))
                                    .cornerRadius(10)
                                }
                                Button {
                                    
                                } label: {
                                    
                                    HStack(alignment: .center, spacing: 10) {
                                        
                                        Image("google")
                                        Text("Continue with Google")
                                            .foregroundColor(Color("textDarkBlue"))
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                    }
                                    .frame(height: 52)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("textDarkBlue"), lineWidth: 0.5))
                                    
                                }
                                Button {
                                    
                                } label: {
                                    
                                    HStack(alignment: .center, spacing: 10) {
                                        
                                        Image("apple")
                                        Text("Continue with Apple")
                                            .foregroundColor(Color("textWhite"))
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                        
                                    }
                                    .frame(height: 52)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                }
                            }
                            
                        }
                    }
                    .foregroundColor(Color("Text"))
                }
                .padding(.horizontal, 16)
                .banner(data: $login.bannerData, show: $login.showBanner)
            }
            
        }
        .navigationBarHidden(true)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView().preferredColorScheme($0)
        }
    }
}




