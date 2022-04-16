//
//  SettingView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/3/2022.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .center){
                TopLogoBar()
                    .ignoresSafeArea()
                Form{
                    Section(content: {
                        NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com")
                        NavigateRowView(logoName: "Instagram", logoBackGround: Color.purple, image: "instagram", link: "https://www.instagram.com")
                        NavigateRowView(logoName: "Twitter", logoBackGround: Color.blue, image: "twitter-fill", link: "https://www.twitter.com")
                        NavigateRowView(logoName: "Github", logoBackGround: Color.black, image: "github-fill", link: "https://www.github.com")
                        
                    }, header: {
                        Text("Follow our media")
                            .foregroundColor(.white)
                    })

                    Section(content: {
                        RowView(icon: "gear", leftText: "Application", rightText: "3D Scanner")
                        RowView(icon: "checkmark.seal", leftText: "Compatibility", rightText: "IPhone, IPad")
                        RowView(icon: "keyboard", leftText: "Front-End Design", rightText: "Walter, Jackie")
                        RowView(icon: "server.rack", leftText: "Back-End Design", rightText: "Shiguang")
                        RowView(icon: "ipad.and.iphone", leftText: "Version", rightText: "0.0.2")
                    }, header: {
                        Text("Application Preferences")
                            .foregroundColor(.white)
                    })
                }
                TabBar(selectedTab: $tab.selectedTab)
            }
        }
        .ignoresSafeArea()
    }
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
