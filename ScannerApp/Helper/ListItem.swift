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
                        Text(String(model.status))
                            .foregroundColor(model.status == 1  ? Color.green : Color.black)
                            .font(.system(size: 20, weight: .bold))
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
                        Button(action: {

                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("Delete"))
                                Label("Delete", systemImage: "xmark.circle")
                                     .font(.system(size: 16, weight: .bold, design: .rounded))
                                     .padding(3)
                                     .foregroundColor(Color("DeleteText"))
                            }
                        })
                        .frame(maxWidth: .infinity)
                        .buttonStyle(BorderedButtonStyle())
                        Spacer()
                        NavigationLink(destination: LazyView(ModelDetailView(model: model)), label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("Download"))
                                Label("Download", systemImage: "arrow.down.circle")
                                     .font(.system(size: 16, weight: .bold, design: .rounded))
                                     .padding(3)
                                     .foregroundColor(Color("DownloadText"))
                            }
                        })
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

