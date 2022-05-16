//
//  InfoAlertView.swift
//  ScannerApp
//
//  Created by Walter Siu on 15/4/2022.
//

import SwiftUI

struct InfoAlertView: View {
    
    @Binding var showAlert: ShowAlert
    var type: ShowAlert
    var image: String
    var name: String
    var major: String
    var lang: [String]
    var part: String
    var github: String
    var linkedin: String
    var boxHeight: CGFloat
    
    var body: some View {
        
        // Display format for profile message box of Jing Ma
        if(self.name == "Jing Ma"){
            ZStack{
                VStack{
                    HStack{
                        Image(self.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 70, height: 60)
                            .padding(.top, 10)
                            .padding(.trailing, 0)
                            .padding(.leading, 5)
                        VStack(alignment: .leading){
                            Text(self.name)
                                .font(.system(size: 21))
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.trailing, 32)
                                .padding(.top, 10)
                            Text(self.part)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 3)
                                .padding(.bottom, 0)
                        }

                        Button {
                            self.showAlert = ShowAlert.none
                        } label: {
                            Image(systemName: "xmark")
                                .resizable().frame(width: 15, height: 15).padding(8)
                        }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                        .padding(.top, 0)
                        .padding(.trailing, 20)
                        .padding(.bottom, 0)
                    }
                    Text(self.major)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                }
            }
            .frame(width: 350, height: self.boxHeight)
            .background(Color("Background").opacity(0.85))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            .cornerRadius(30)
        } else {
            // Display format for person message box of any other person
            ZStack{
                VStack{
                    HStack{
                        Image(self.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 70, height: 60)
                            .padding(.top, 10)
                            .padding(.trailing, 0)
                            .padding(.leading, 5)
                        VStack(alignment: .leading){
                            Text(self.name)
                                .font(.system(size: 21))
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .padding(.trailing, 32)
                                .padding(.top, 10)
                            Text(self.part)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 3)
                                .padding(.bottom, 0)
                        }

                        Button {
                            self.showAlert = ShowAlert.none
                        } label: {
                            Image(systemName: "xmark")
                                .resizable().frame(width: 15, height: 15).padding(8)
                        }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                        .padding(.top, 0)
                        .padding(.trailing, 20)
                        .padding(.bottom, 0)
                    }
                    
                    HStack{
                        Image(systemName: "book.fill")
                            .foregroundColor(Color.white)
                        Text(self.major)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 5)

                    VStack{
                        HStack{
                            Image(systemName: "keyboard.fill")
                                .foregroundColor(Color.white)
                            Text("Programming Language:")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 0)
                        HStack{
                            ForEach(self.lang) { x in
                                Image(x)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                            }
                            
                            HStack{
                                // Button that hyperlink to person's github website
                                Button {
                                    guard let github = URL(string: self.github),
                                          UIApplication.shared.canOpenURL(github) else {
                                            return
                                    }
                                    UIApplication.shared.open(github,
                                                                   options: [:],
                                                                   completionHandler: nil)
                                } label: {
                                    Image("github")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(Color.white)
                                }
                                
                                // Button that hyperlink to person's linkedin website
                                Button {
                                    guard let linkedin = URL(string: self.linkedin),
                                          UIApplication.shared.canOpenURL(linkedin) else {
                                            return
                                    }
                                    UIApplication.shared.open(linkedin,
                                                                   options: [:],
                                                                   completionHandler: nil)
                                } label: {
                                    Image("linkedin")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .scaledToFit()
                                        .foregroundColor(Color.white)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 18)
                    }
                    .padding(.bottom, 5)
                    Spacer()
                }
            }
            .frame(width: 350, height: self.boxHeight)
            .background(Color("Background").opacity(0.85))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            .cornerRadius(30)
        }
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
