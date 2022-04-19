//
//  RowView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/3/2022.
//

import SwiftUI

struct RowView: View {
    
    @State var icon:String
    @State var leftText:String
    @State var rightText:String
    @State var isTopCorner:Bool
    @State var isBottomCorner:Bool
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.gray)
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .foregroundColor(Color("DisabledText"))
            }
            Text(leftText)
                .foregroundColor(Color("DisabledText"))
            Spacer()
            Text(rightText)
                .foregroundColor(Color("DisabledText"))
        }
        .padding(10)
        .background{
            if isTopCorner && isBottomCorner{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Background"))
                    .opacity(0.85)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    .padding(.horizontal, 20)
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
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(icon: "gear", leftText: "Setting", rightText: "Doing", isTopCorner: true, isBottomCorner: false)
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
