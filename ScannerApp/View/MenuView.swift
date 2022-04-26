//
//  ContentView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI

struct MenuView: View {
    
    @State var offset:CGSize = CGSize(width: 0, height:0)
    @StateObject var tab:TabSettings = TabSettings()
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            switch tab.selectedTab{
            case "house":
                ZStack(alignment: .center, content: {
                    HomePageV2()
                        .statusBar(hidden: true)
                })
                    .ignoresSafeArea()
            case "viewfinder.circle":
                ZStack(alignment: .center, content: {
                    CameraView()
                        .statusBar(hidden: true)
                })
                    .ignoresSafeArea()
            case "photo":
                ZStack(alignment: .center, content: {
                    ModelListView()
                        .statusBar(hidden: true)
                })
                    .ignoresSafeArea()
            case "icloud.and.arrow.up":
                ZStack(alignment: .center, content: {
                    UploadModelView()
                        .statusBar(hidden: true)
                })
                    .ignoresSafeArea()
            case "person.3":
                ZStack(alignment: .center, content: {
                    AboutUsView()
                        .statusBar(hidden: true)

                })
                    .ignoresSafeArea()
            case "gearshape":
                ZStack(alignment: .center, content: {
                    SettingView()
                        .statusBar(hidden: true)
                })
            default:
                ZStack(alignment: .center, content: {
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                    Text("Error")
                })
                    .ignoresSafeArea()
            }
        })
        .environmentObject(tab)
    }
}
