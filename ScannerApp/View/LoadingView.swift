//
//  LoadingView.swift
//  ScannerApp
//
//  Created by Walter Siu on 10/3/2022.
//

import SwiftUI

struct LoadingView: View {
    @State var startAnimation = false
    @State var leaveAnimation = false
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                
                let size = proxy.size
                
                ZStack {
                    
                    if !leaveAnimation{
                        Image("Logoupper")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width / 2, height: size.height / 2, alignment: .top)
                            .foregroundColor(Color.white)
                            .opacity(startAnimation ? 1 : 0)

                        Image("Logolower")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width / 2, height: size.height / 2)
                            .foregroundColor(Color.white)
                        // Appear Animation
                            .opacity(startAnimation ? 1 : 0)
                        // Move up Animation
                            .offset(y: startAnimation ? -80 : 0)
                        VStack {
                            Spacer()
                            Text("Copyright © 2020\nAll rights reserved")
                            .foregroundColor(Color(red: 66/255, green: 150/255, blue: 157/255))
                            .opacity(startAnimation ? 1 : 0)
                            .offset(y: 30)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        }
                    }
                        MenuView()
                            .opacity(showMenu ? 1 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring()) {
                    startAnimation.toggle()
                }
                withAnimation(Animation.easeOut(duration: 1).delay(2.5)) {
                    leaveAnimation.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.8){
                withAnimation(.spring()) {
                    showMenu = true
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
