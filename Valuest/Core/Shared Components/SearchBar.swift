//
//  SearchBar.swift
//  Valuest
//
//  Created by Arthur Olevsky on 30.04.2022.
//

import SwiftUI

struct SearchBar: View {
    
    let placeholder: String
    @Binding var isSearching: Bool
    @Binding var searchQuery: String
    
    
    var body: some View {
        HStack(spacing: 16) {
            HStack {
                Image(systemName: "magnifyingglass")
                ZStack(alignment: .leading) {
                    if !isSearching {
                        Text(placeholder)
                            .font(.callout)
                    }
                    TextField("", text: $searchQuery)
                        .font(.callout)
                        .disableAutocorrection(true)
                }
                .onTapGesture {
                    withAnimation(.linear(duration: 0.2)) {
                        isSearching = true
                    }
                }
            }
            .foregroundColor(Color("SearchText"))
            .padding(9)
            .background(Color("CardBackground"))
            .cornerRadius(10)
            
            if isSearching {
                Button {
                    withAnimation(.linear(duration: 0.2)) {
                        isSearching = false
                        searchQuery = ""
                        self.hideKeyboard()
                    }
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 4)
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 30)
    }
}

