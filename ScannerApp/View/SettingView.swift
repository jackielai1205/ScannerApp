//
//  SettingView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/3/2022.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        ZStack{
            Color("Background")
            VStack(alignment: .center){
                
                TopLogoBar()
                    .ignoresSafeArea()
                
                Form{
                        NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com")
                        NavigateRowView(logoName: "Instagram", logoBackGround: Color.purple, image: "instagram", link: "https://www.instagram.com")
                        NavigateRowView(logoName: "Twitter", logoBackGround: Color.blue, image: "twitter-fill", link: "https://www.twitter.com")
                        NavigateRowView(logoName: "Github", logoBackGround: Color.black, image: "github-fill", link: "https://www.github.com")

                    Section(content: {
                        RowView(icon: "gear", leftText: "Application", rightText: "3D Scanner")
                        RowView(icon: "checkmark.seal", leftText: "Compatibility", rightText: "IPhone, IPad")
                        RowView(icon: "keyboard", leftText: "Front-End Design", rightText: "Walter, Jackie")
                        RowView(icon: "server.rack", leftText: "Back-End Design", rightText: "Shiguang")
                        RowView(icon: "ipad.and.iphone", leftText: "Version", rightText: "0.0.2")
                    }, header: {
                        Text("Application Preferences")
                            .foregroundColor(.black)
                    })

                }
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
