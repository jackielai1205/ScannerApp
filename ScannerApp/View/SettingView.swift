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
                .ignoresSafeArea()
            VStack(alignment: .center){
                Form{
                    Section(header: Text("About the application")
                                .foregroundColor(.black), content: {
                        RowView(icon: "gear", leftText: "Setting", rightText: "Todo")
                    })
                    
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }
        }
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
