//
//  HomePageV2.swift
//  ScannerApp
//
//  Created by Walter Siu on 12/4/2022.
//

import SwiftUI
import WebKit
import SceneKit

struct HomePageView: View {
    
    @State var menu = 0
    @State var page = 0
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        
        ZStack{
            // Set background color to Image(Background)
            Image("Background")
                .resizable()
                .ignoresSafeArea();
            VStack{
                
                // Logo bar positing at top of the page
                TopLogoBar();
                
                VStack{
                    GeometryReader { x in
                        // Horizontal scroll list for display different demo model
                        HomePageCarousel(width: UIScreen.main.bounds.width, height: x.frame(in: .global).height, page: self.$page)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
                    
                    // Represent total page number and current page position
                    PageController(page: self.$page)
                    
                    Spacer()
                    
                    TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
                }
            }
        }
    }
}

struct Type: Identifiable{
    var id: Int
    var name: String
    var photoNum: String
    var time: String
    var image: String
    var model: String
}

// Demo model information
var data = [
    Type(id: 0, name: "Figure - Nergigante", photoNum: "196", time: "30", image: "dragon", model: "dragon.usdz"),
    Type(id: 1, name: "Figure - Velkhana", photoNum: "35", time: "3", image: "icedragon", model: "icedragon.usdz"),
    Type(id: 2, name: "Figure - Eva", photoNum: "78", time: "5", image: "eva", model: "eva.usdz")
]

struct HomePageV2_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


