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
            VStack(){
                TopLogoBar()
                Spacer()
                VStack(spacing: 0){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                        Text("Follow Our Media")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 80, maxHeight: 20)
                    NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com", isTopCorner: true, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    NavigateRowView(logoName: "Instagram", logoBackGround: Color.purple, image: "instagram", link: "https://www.instagram.com", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    NavigateRowView(logoName: "Twitter", logoBackGround: Color.blue, image: "twitter-fill", link: "https://www.twitter.com", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    NavigateRowView(logoName: "Github", logoBackGround: Color.black, image: "github-fill", link: "https://github.com/jackielai1205/ScannerApp", isTopCorner: false, isBottomCorner: true)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                }
                Spacer()
                VStack(spacing: 0){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                        Text("Application Preferences")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 80, maxHeight: 20)
                    RowView(icon: "gear", leftText: "Application", rightText: "3D Scanner", isTopCorner: true, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "checkmark.seal", leftText: "Compatibility", rightText: "IPhone", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "keyboard", leftText: "Front-End Design", rightText: "Walter, Jackie", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "server.rack", leftText: "Back-End Design", rightText: "Shiguang, Jackie", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "ipad.and.iphone", leftText: "Version", rightText: "1.0.0", isTopCorner: false, isBottomCorner: true)
                }
                Spacer()
                TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
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
