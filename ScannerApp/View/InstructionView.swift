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
                    
                    VStack{
                        Image("InstructionImage")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 10)
                            .frame(width: UIScreen.main.bounds.width - 200)
                        Spacer()
                    }
                    .frame(height: 400)
                    .frame(maxWidth:.infinity)
                    .background(Color.brown)
                    .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeOut)
        }
    }

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}
