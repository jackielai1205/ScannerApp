//
//  NoRecordFoundView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 27/4/2022.
//

import SwiftUI

struct NoRecordFoundView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray)
                .frame(maxHeight: 60)
            VStack{
                Label("No Record Found", systemImage: "photo.on.rectangle.angled")
                    .foregroundColor(Color.white)
                    .font(.system(size: 15, weight:.bold))

            }
        }
        .ignoresSafeArea()
    }
}

struct NoRecordFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoRecordFoundView()
    }
}
