//
//  HomePageView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI
import SceneKit

struct HomePageView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    TopLogoBar()
                }
            }
            SceneView(scene: SCNScene(named: "dragon.usdz") , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
