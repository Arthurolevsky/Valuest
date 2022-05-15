//
//  SignUpView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI

struct RegistrationView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionManager
    @StateObject var registration = RegistrationService()
    var dismiss: DismissAction
    
    var body: some View {
        // MARK: Sign Up View
        ZStack(alignment: .top) {
            
            // MARK: View Background
            Color("Background")
                .ignoresSafeArea()
            
            // MARK: Sign Up View Content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Logo
                    Image("Logo_16x85")
                    
                    VStack(alignment: .leading, spacing: 26) {
                        
                        // Header
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Create account")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("Already have an account?")
                                    .font(.callout)
                                HStack(spacing: 4) {
                                    NavigationLink {
                                        LoginView(dismiss: dismiss)
                                    } label: {
                                        Text("Login")
                                            .foregroundColor(.blue)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .font(.callout)
                            }
                        }
                        
                        // Sign Up Inputs
                        VStack(alignment: .leading, spacing: 16) {
                            FullNameField(text: $registration.fullName)
                            EmailField(text: $registration.email,
                                       isValid: registration.isEmailValid)
                            PasswordField(text: $registration.password,
                                          isValid: registration.isPasswordValid)
                        }
                        
                        // Create account button and Socials
                        VStack(alignment: .center, spacing: 24) {
                            
                            RegistrationButton(isValid: registration.isFormInvalid) {
                                registration.userRegistration()
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
                            VStack(alignment: .center, spacing: 2) {
                                HStack(alignment: .lastTextBaseline, spacing: 4) {
                                    Spacer()
                                    Text("By sign up, you’re agree to our")
                                    NavigationLink {
                                        TermsOfUse()
                                    } label: {
                                        Text("Terms of Use")
                                            .fontWeight(.semibold)
                                    }
                                    Spacer()
                                }
                                HStack(alignment: .lastTextBaseline, spacing: 4) {
                                    Text("and")
                                    NavigationLink {
                                        PrivacyPolicy()
                                    } label: {
                                        Text("Privacy Policy")
                                            .fontWeight(.semibold)
                                    }
                                }
                            }
                            .font(.footnote)
                        }
                        
                    }
                    .foregroundColor(Color("Text"))
                }
                .padding(.top, 24)
            }
            .padding(.horizontal, 16)
            
            // Dismiss Button
            DismissAuthButton(dismiss: dismiss)

        }
        .navigationBarHidden(true)
        .banner(data: $registration.bannerData, show: $registration.showBanner)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}
