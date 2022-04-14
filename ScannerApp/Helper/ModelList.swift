//
//  ModelList.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/4/2022.
//

import SwiftUI

struct ModelList: View {
    
    @State var model:ModelDetail
    
    var body: some View {
        HStack{
            Text("\(model.modelid)")
                .padding()
            Divider()
            Spacer()
            Text(model.receivetime)
            Spacer()
            Text(model.status)
            if (model.status == "Completed"){
                Button(action: {
                }, label: {
                    Image(systemName: "icloud.and.arrow.down")
                            .padding()
                })
            }else{
                Image(systemName: "icloud.slash")
                    .padding()
            }

        }
        .foregroundColor(model.status == "Completed" ? Color.black : Color.gray)
        }
}

struct ModelList_Previews: PreviewProvider {
    static var previews: some View {
        ModelList(model: ModelDetail(modelid: 19, location: "/Users/jackielai/Desktop/Test/0.9551758485562629", status: "Processing", owner: "F4655CDB-EC1F-41EF-A674-79868A629937", receivetime: "04/14/2022")).previewLayout(.fixed(width: 375, height: 60))
    }
}
