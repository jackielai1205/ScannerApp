//
//  ContentView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = "viewfinder.circle"
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            switch selectedTab{
            case "viewfinder.circle":
                ZStack(alignment: .center, content: {
                    Color.red
                        .ignoresSafeArea()
                    Text("Scan")
                })
            case "person":
                ZStack(alignment: .center, content: {
                    Color.blue
                        .ignoresSafeArea()
                    Text("View")
                })
            case "icloud.and.arrow.up":
                ZStack(alignment: .center, content: {
                    Color.green
                        .ignoresSafeArea()
                    Text("Upload")
                })
            case "person.3":
                ZStack(alignment: .center, content: {
                    Color.yellow
                        .ignoresSafeArea()
                    Text("About")
                })
            case "gearshape":
                ZStack(alignment: .center, content: {
                    Color.blue
                        .ignoresSafeArea()
                    Text("Setting")
                })
            default:
                ZStack(alignment: .center, content: {
                    Color.black
                        .ignoresSafeArea()
                    Text("Error")
                })
            }
            TabBar(selectedTab: $selectedTab)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: "viewfinder.circle")
    }
}
