//
//  ListItem.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 16/4/2022.
//

import SwiftUI

struct ListItem: View {
    
    @State var model: TransactionsData
    @Binding var isDisplay:Bool
    @Binding var displayMessage:String
    @State var isErrorMessagePresented = false
    
    //Arrange individual list item
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
                                Text("Model Serial Number: \(String(model.tranID))")
                                Text("Receivce Data:  \(model.date)")
                                Text("Receivce Time: \(model.time)")
                            }
                            .padding()
                        }
                    }
                    .padding(.horizontal, 10)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.white)
                    HStack{
                        ListItemButton(model: model, isDisplay: $isDisplay, displayMessage: $displayMessage)
                            .frame(maxWidth: .infinity)
                            .buttonStyle(BorderedButtonStyle())
                        if(model.errorMessage != nil){
                            ZStack{
                                Button(action: {
                                    isErrorMessagePresented = true
                                },
                                   label: {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.red)
                                            Label("Show Error", systemImage: "questionmark.circle")
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color.black)
                                                .padding(3)
                                        }
                                })
                            }
                            .frame(maxWidth: .infinity)
                            .buttonStyle(BorderedButtonStyle())
                        }
                    }
                }
            }
        }
        .alert(model.errorMessage ?? "nil", isPresented: $isErrorMessagePresented){
            Button("OK"){}
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}

