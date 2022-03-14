//
//  RowView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/3/2022.
//

import SwiftUI

struct RowView: View {
    
    var icon:String
    var leftText:String
    var rightText:String
    
    var body: some View {
        HStack{
            
            ZStack{
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(.gray)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36)
            Text(leftText)
                .foregroundColor(.gray)
            Spacer()
            Text(rightText)
                .foregroundColor(.gray)
        }
        .padding(.vertical,2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(icon: "gear", leftText: "Setting", rightText: "Doing")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
