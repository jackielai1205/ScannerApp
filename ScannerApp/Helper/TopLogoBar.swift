//
//  TopLogoBar.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI


//Top bar
struct TopLogoBar: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("Background")
                .opacity(0.75)
                .ignoresSafeArea(.all)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .padding(.bottom,20)
        }
        .frame(width: UIScreen.main.bounds.width, height: 120)
        .offset(y: -185)
    }
}

struct TopLogoBar_Previews: PreviewProvider {
    static var previews: some View {
        TopLogoBar()
    }
}
