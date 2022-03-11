//
//  ContentView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI

struct MenuView: View {
    
    @State var selectedTab = "house"
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            
            switch selectedTab{
            case "house":
                ZStack(alignment: .center, content: {
                    HomePageView()
//                    Color("Background")
//                    Text("Home")
                })
                    .ignoresSafeArea()
            case "viewfinder.circle":
                ZStack(alignment: .center, content: {
                    Color("Background")
                    Text("Scan")
                })
                    .ignoresSafeArea()
            case "photo":
                ZStack(alignment: .center, content: {
                    Color("Background")
                    Text("View")
                })
                    .ignoresSafeArea()
            case "icloud.and.arrow.up":
                ZStack(alignment: .center, content: {
                    Color("Background")
                    Text("Upload")
                })
                    .ignoresSafeArea()
            case "person.3":
                ZStack(alignment: .center, content: {
                    AboutUsView()
                })
                    .ignoresSafeArea()
            case "gearshape":
                ZStack(alignment: .center, content: {
                    Color("Background")
                    Text("Setting")
                })
                    .ignoresSafeArea()
            default:
                ZStack(alignment: .center, content: {
                    Color("Background")
                    Text("Error")
                })
                    .ignoresSafeArea()
            }
            TabBar(selectedTab: $selectedTab)
        })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(selectedTab: "viewfinder.circle")
    }
}
