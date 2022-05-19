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
    @State var isTopCorner:Bool
    @State var isBottomCorner:Bool
    
    //NavigteRow for the setting page which direct to specific website
    var body: some View {
        Link(destination: URL(string: link)!, label: {
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(logoBackGround)
                        .frame(width: 36, height: 36)
                        .padding(10)
                    Image(image)
                        .foregroundColor(.white)
                }
                Text(logoName)
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .padding(.trailing, 10)
            }
            .foregroundColor(Color.black)
            .background{
                if isTopCorner && isBottomCorner{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Background"))
                        .opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                }
                else if isTopCorner{
                    Rectangle()
                        .fill(Color("Background"))
                        .opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                }else if isBottomCorner{
                    Rectangle()
                        .fill(Color("Background"))
                        .opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                }
                else{
                    Rectangle()
                        .fill(Color("Background"))
                        .opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                }
            }
            .padding(.horizontal, 20)
        })
    }
}



struct NavigateRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigateRowView(logoName: "Facebook", logoBackGround: .blue, image: "facebook-circle", link: "https://www.facebook.com", isTopCorner: true, isBottomCorner: false)
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
