//
//  BannerModifier.swift
//  Valuest
//
//  Created by Arthur Olevsky on 16.03.2022.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    
    @Binding var data: BannerData
    @Binding var showBanner: Bool
    
    @GestureState private var dragOffset = CGSize.zero
    
    private var dragGesture: some Gesture {
        return DragGesture()
            .updating($dragOffset) { value, state, transaction in
                var movement = value.translation.height
                movement = min(20, value.translation.height)
                state = CGSize(width: value.translation.width, height: movement)
            }
            .onEnded { value in
                if value.translation.height <= -30 {
                    withAnimation {
                        self.showBanner = false
                    }
                }
            }
    }

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if showBanner {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(data.title)
                                .fontWeight(.bold)
                            Text(data.message)
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(data.type.tintColor)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .animation(.easeInOut(duration: 0.2))
                .offset(x: 0, y: dragOffset.height)
                .transition(AnyTransition.move(edge: .top))
                .onTapGesture {
                    withAnimation {
                        self.showBanner = false
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.showBanner = false
                        }
                    }
                }
            }
        }
    }
}


struct BannerModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(BannerModifier(data: Binding<BannerData>.constant(BannerData(title: "Unable to login", message: "Please check login or password and try again.", type: .Error)), showBanner: Binding<Bool>.constant(true)))
    }
}

extension View{
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, showBanner: show))
    }
}
