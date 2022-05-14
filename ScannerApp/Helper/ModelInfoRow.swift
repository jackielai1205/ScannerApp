//
//  ModelInfoRow.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 22/4/2022.
//

import SwiftUI

struct ModelInfoRow: View {
    
    @State var description:String
    @State var sfImage: String
    @State var data:String
    
    var body: some View {
        HStack(alignment:.center){
            Label("**\(description)**", systemImage: sfImage)
                .frame(maxWidth:.infinity)
            Text("**\(data)**")
                .frame(maxWidth:.infinity)
        }
    }
}

struct ModelInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        ModelInfoRow(description: "Model ID:", sfImage: "info.circle", data: "1")
    }
}
