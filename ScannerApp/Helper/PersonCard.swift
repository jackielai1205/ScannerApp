//
//  PersonCard.swift
//  ScannerApp
//
//  Created by Walter Siu on 15/4/2022.
//

import SwiftUI

struct PersonCard: View{
    
    @Binding var showAlert: ShowAlert
    var type: ShowAlert
    var image: String
    var name: String
    var major: String
    var lang: String
    var part: String
    var color: Color
    
    var body: some View{
        ZStack{
            HStack{
                Button {
                    showAlert = type
                } label: {
                    HStack(alignment: .center){
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .clipShape(Circle())
                            .padding(.vertical, 10)
                            .padding(.leading, 10)
                        
                        Divider()
                                    
                        VStack(alignment: .leading){
                            Text(name)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .fontWeight(.bold)
                                .foregroundColor(self.color)
                                .padding(.bottom, 5)
                            Text(part)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(self.color)
                        }
                        Spacer()
                    }
                    .background(AngularGradient(gradient: Gradient(colors: [.white, self.color]), center: .topLeading))
                    .modifier(CardModifier())
                    .padding(.horizontal, 20)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1, height: 90)
        .padding(.bottom, 10)
        .animation(.spring())
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .opacity(0.9)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
    }
}
