//
//  ResetPasswordView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 08.03.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: ResetPassService = ResetPassService()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                
                VStack(alignment: .leading, spacing: 37) {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("Back", systemImage: "chevron.left")
                                .foregroundColor(Color("Text"))
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 26) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Forgot you password?")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Text"))
                            Text("Enter your email to reset password")
                                .font(.callout)
                                .foregroundColor(Color("Text"))
                           
                        }
                        EmailField(text: $vm.email, isValid: vm.isEmailValid)
                        Button {
                            vm.resetPassword()
                        } label: {
                            Text("Reset password")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor(Color("textWhite"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 52, alignment: .center)
                                .background(vm.isFormInvalid ? Color.gray :  Color("PrimaryButton"))
                                .cornerRadius(10)
                        }
                        .disabled(vm.isFormInvalid)
                    }
                    
                }
                .padding(.horizontal)
                .banner(data: $vm.bannerData, show: $vm.showBanner)
            }
        }
        .navigationBarHidden(true)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ResetPasswordView().preferredColorScheme($0)
        }
    }
}
