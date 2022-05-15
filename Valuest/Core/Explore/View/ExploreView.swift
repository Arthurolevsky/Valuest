//
//  ExploreView.swift
//  Valuest
//
//  Created by Arthur Olevsky on 09.03.2022.
//

import SwiftUI

struct ExploreView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sideMenu: SideMenuViewModel
    
    @StateObject var vm = ExploreViewModel()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            if !vm.isSearching {
                NavigationBar(viewRouter: viewRouter)
                    .environmentObject(session)
                    .environmentObject(sideMenu)
            }
            ScrollView(.vertical, showsIndicators: false) {
                
                SearchBar(placeholder: "Search symbol or company", isSearching: $vm.isSearching, searchQuery: $vm.searchQuery)
                    .onChange(of: vm.searchQuery) { query in
                        if !query.isEmpty {
                            vm.searchedSymbols = vm.symbols.filter({ $0.Code.lowercased().contains(query.lowercased()) || $0.Name.lowercased().contains(query.lowercased()) })
                        } else {
                            vm.searchedSymbols = []
                        }
                    }
                
                if !vm.isSearching && vm.searchQuery.isEmpty {
                    VStack(alignment: .leading, spacing: 36) {
                        VStack(alignment: .leading, spacing: 18) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Indices")
                                    .font(.title2.bold())
                                    .foregroundColor(Color("Text"))
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LineChart(data: sampleData.normalized)
                                    .frame(width: 130, height: 110)
                            }
                        }
                    }
                } else {
                    ForEach(vm.searchedSymbols.prefix(10), id: \.Code) { symbol in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("\(symbol.Code)")
                                Text("\(symbol.Name)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(symbol.Country)")
                                Text("\(symbol.`Type`)")
                            }
                        }
                        .padding(4)
                    }
                }
            }
        }
        .task {
            await vm.getSymbols()
        }
        .padding(.horizontal)
        .frame(width: getRect().width)
        
    }
}


let sampleData: [CGFloat] = [4778.14014,4783.66016,4781.66016,4787.5,4787.3999,4787.6499,4789.8999, 4792.5, 4791.12988, 4789.02979, 4789.64014, 4789.7002, 4788.60986, 4789.7002, 4788.60986, 4789.18994, 4788.02979, 4786.12012]
