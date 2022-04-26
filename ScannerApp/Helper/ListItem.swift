//
//  ListItem.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 16/4/2022.
//

import SwiftUI

struct ListItem: View {
    
    @State var model: TransactionsData
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment:.leading,  spacing: 10){
                    HStack{
                        Text(model.modelName)
                            .font(.system(size: 20.0, weight: .bold, design: .rounded))
                            .foregroundColor(Color.black)
                        Spacer()
                        switch(model.status){
                        case 0:
                            Text("Processing")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 20, weight: .bold))
                        case 1:
                            Text("Ready")
                                .foregroundColor(Color.green)
                                .font(.system(size: 20, weight: .bold))
                        case 2:
                            Text("Failure")
                                .foregroundColor(Color.red)
                                .font(.system(size: 20, weight: .bold))
                        default:
                            Text("Error")
                                .foregroundColor(Color.red)
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                    .padding(.horizontal, 10)
                    VStack{
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                            VStack(alignment:.center){
                                Text("Model Receivce:  \(model.date)")
                                Text("Model Serial Number: \(String(model.tranID))")
                            }
                            .padding()
                        }
                    }
                    .padding(.horizontal, 10)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    HStack(alignment:.center){
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(model.status == 1 ? Color("Download") : Color.gray)
                            Label("View", systemImage: "arrow.down.circle")
                                 .font(.system(size: 16, weight: .bold, design: .rounded))
                                 .padding(3)
                                 .foregroundColor(model.status == 1 ? Color("DownloadText") : Color.black)
                        }
                        .background( NavigationLink("", destination: ModelDetailView(model: model)).opacity(0)
                            .disabled(!(model.status == 1))
                        )
                        .frame(maxWidth: .infinity)
                        .buttonStyle(BorderedButtonStyle())
                    }
                }
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}

