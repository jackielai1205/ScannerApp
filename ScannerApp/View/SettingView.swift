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
                    NavigateRowView(logoName: "Github", logoBackGround: Color.black, image: "github-fill", link: "https://www.github.com", isTopCorner: false, isBottomCorner: true)
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
                    RowView(icon: "checkmark.seal", leftText: "Compatibility", rightText: "IPhone, IPad", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "keyboard", leftText: "Front-End Design", rightText: "Walter, Jackie", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "server.rack", leftText: "Back-End Design", rightText: "Shiguang", isTopCorner: false, isBottomCorner: false)
                    Divider()
                        .frame(width: UIScreen.main.bounds.width - 40)
                    RowView(icon: "ipad.and.iphone", leftText: "Version", rightText: "0.0.2", isTopCorner: false, isBottomCorner: true)
                }
                Spacer()
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

//                List{
//                    Section(content: {
//                        NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com")
//                        NavigateRowView(logoName: "Instagram", logoBackGround: Color.purple, image: "instagram", link: "https://www.instagram.com")
//                        NavigateRowView(logoName: "Twitter", logoBackGround: Color.blue, image: "twitter-fill", link: "https://www.twitter.com")
//                        NavigateRowView(logoName: "Github", logoBackGround: Color.black, image: "github-fill", link: "https://www.github.com")
//                    }, header: {
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 20)
//                                .fill(Color.gray)
//                            Text("Follow Our Media")
//                                .foregroundColor(.white)
//                                .font(.system(size: 16))
//                        }
//                    })
//                    .listRowBackground(Color("Background")
//                        .opacity(0.85)
//                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10))
//                }
//                .disabled(true)
