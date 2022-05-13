//
//  InstructionView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 15/4/2022.
//

import SwiftUI

struct InstructionView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
            ZStack(alignment:.bottom){
                if isShowing{
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing = false
                        }
                    
                    VStack(alignment: .leading){

                        HStack{
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.title)
                            Text("App Using Guideline")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.trailing, 40)
                        }
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        instruction(imageName: "1.circle", text: "Click to Scan Page to scan object")
                        instruction(imageName: "2.circle", text: "Keep object background clear and white")
                        instruction(imageName: "3.circle", text: "Keep camera stable")
                        instruction(imageName: "4.circle", text: "Slowly rotate object and take around 40 photos from different angle")
                        instruction(imageName: "5.circle", text: "Back to upload page and click select to choose photos from your phone")
                        instruction(imageName: "6.circle", text: "Click upload")
                        instruction(imageName: "7.circle", text: "Wait for model processing and visit view page to view your model")
                        Image("360")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .frame(height: 340)
                    .frame(maxWidth:.infinity)
//                    .background(Color.brown)
                    .background(Color("Background").opacity(0.9))
                    .cornerRadius(20)
                    .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeOut)
        }
    }

struct instruction: View{
    
    var imageName: String
    var text: String
    
    var body: some View{
        HStack{
            Image(systemName: imageName)
            Text(text)
                .font(.system(size: 12))
        }
        .foregroundColor(Color.white)
        .padding(.leading, 10)
        .padding(.trailing, 5)
        .padding(.bottom, 2)
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}
