//
//  HomePageWebList.swift
//  ScannerApp
//
//  Created by Walter Siu on 16/5/2022.
//

import SwiftUI

struct HomePageWebList: View{
    
    @Binding var page: Int
    
    var body: some View{
        HStack(spacing: 0){
            ForEach(data){ i in
                HomePageModelCard(page: self.$page, width: UIScreen.main.bounds.width, data: i)
            }
        }
    }
}
