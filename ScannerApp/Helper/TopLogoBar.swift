//
//  TopLogoBar.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI

struct TopLogoBar: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("LogoBarBackground")
                .ignoresSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: 500)
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
                .padding(.bottom,20)
        }
        .frame(width: UIScreen.main.bounds.width, height: 150)
        .offset(y: -175)
    }
}

struct TopLogoBar_Previews: PreviewProvider {
    static var previews: some View {
        TopLogoBar()
    }
}
