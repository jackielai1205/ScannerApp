//
//  NavigateRowView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 14/3/2022.
//

import SwiftUI

struct NavigateRowView: View {
    
    @State var logoName:String
    @State var logoBackGround:Color
    @State var image:String
    @State var link:String
    
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(logoBackGround)
                    .frame(width: 36, height: 36)
                Image(image)
                    .foregroundColor(.white)
            }
            Text(logoName)
            Spacer()
            
            Link(destination: URL(string: link)!, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            })
        }
        .padding(.vertical,2)
    }
}




struct NavigateRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
