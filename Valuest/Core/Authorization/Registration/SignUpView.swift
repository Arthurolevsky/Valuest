//
//  SignUpView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var registration = RegistrationService()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView { 
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    Image("Logox16")
                    
                    VStack(alignment: .leading, spacing: 26) {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Create account")
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("Already have an account?")
                                    .font(.callout)
                                HStack(spacing: 4) {
                                    NavigationLink {
                                        SignInView()
                                    } label: {
                                        Text("Login")
                                            .foregroundColor(.blue)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .font(.callout)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            FullNameField(text: $registration.fullName)
                            EmailField(text: $registration.email,
                                       isValid: registration.isEmailValid)
                            PasswordField(text: $registration.password,
                                          isValid: registration.isPasswordValid)
                        }
                        
                        
                        VStack(alignment: .center, spacing: 24) {
                            
                            Button {
                                print("Button Clicked")
                                registration.userRegistration()
                            } label: {
                                Text("Create free account")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("textWhite"))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48, alignment: .center)
                                    .background(registration.isFormInvalid ? Color.gray :  Color("PrimaryButton"))
                                    .cornerRadius(10)
                                
                            }
                            .disabled(registration.isFormInvalid)
                            
                            Text("Or continue with social account")
                                .foregroundColor(Color("Text"))
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            VStack(spacing: 16) {
                                Button {
                                    print("facebook")
                                } label: {
                                    
                                    HStack(alignment: .center, spacing: 10) {
                                        
                                        Image("facebook")
                                        Text("Continue with Facebook")
                                            .foregroundColor(Color("textWhite"))
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                        
                                    }
                                    .frame(height: 48)
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
                                    .frame(height: 48)
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
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(10)
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
                .padding(.horizontal, 16)
                .banner(data: $registration.bannerData, show: $registration.showBanner)
                
            }
            
        }
        .navigationBarHidden(true)
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView().preferredColorScheme($0)
        }
    }
}


