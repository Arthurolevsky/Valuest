//
//  SideMenu.swift
//  Valuest
//
//  Created by Arthur Olevsky on 13.04.2022.
//

import SwiftUI

struct MainMenu: View {
    
    @Binding var showMenu: Bool
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .center, spacing: 20) {
                    
                    Image("Avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("Arthur Olevskiy")
                            .font(.title3.weight(.semibold))
                        Text("@arthurolevskiy")
                            .font(.callout)
                            .foregroundColor(.black.opacity(0.5))
                        
                    }
                }
                
                HStack(alignment: .center, spacing: 16) {
                    
                    VStack(alignment: .center, spacing: 4) {
                        
                        Image(systemName: "slider.horizontal.3")
                        Text("Screener")
                        
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 66)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 4) {
                        
                        Image(systemName: "calendar")
                        Text("Calendar")
                            .font(.subheadline)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 66)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                
                ScrollView {
                    Button {
                        session.logout()
                    } label: {
                        Text("Logout")
                            .foregroundColor(Color.black.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 60)
        .frame(maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea(.container,edges: .vertical))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(showMenu: .constant(true))
    }
}


