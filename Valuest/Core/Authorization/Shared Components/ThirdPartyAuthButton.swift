//
//  ThirdPartyAuthButton.swift
//  Valuest
//
//  Created by Arthur Olevsky on 30.04.2022.
//

import SwiftUI

struct ThirdPartyAuthButton: View {
    
    let image: String
    let text: String
    let textColor: String
    let background: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            
            HStack(alignment: .center, spacing: 10) {
                
                Image(image)
                Text(text)
                    .foregroundColor(Color(textColor))
                    .font(.subheadline)
                    .fontWeight(.bold)
                
            }
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(Color(background))
            .cornerRadius(10)
        }
    }
}

struct ThirdPartyAuthButton_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartyAuthButton(image: "facebook", text: "Continue with Facebook", textColor: "textWhite", background: "facebookBlue") {
            
        }
    }
}
