//
//  AboutUsView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI
import simd

struct AboutUsView: View {
    
    @State var showAlert = ShowAlert.none
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                TopLogoBar()
                    .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                VStack{
                    ZStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Background").opacity(0.85))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                            .animation(.spring())
                        Text("Teams")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .offset(y: -5)
                            .animation(.spring())
                    }
                    .frame(width: 105, height: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 10)
                    .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.ting, image: "dog", name: "TingFung Siu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Front End", color: Color.blue)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)

                    if(self.showAlert == ShowAlert.ting){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.ting, image: "dog", name: "TingFung Siu", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
                    }
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.jackie, image: "dog", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Frond End & Back End", color: Color.red)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)

                    if(self.showAlert == ShowAlert.jackie){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.jackie, image: "dog", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End and Back End ", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
                    }
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.shi, image: "dog", name: "ShiGuang Yu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Back End", color: Color.green)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)

                    if(self.showAlert == ShowAlert.shi){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.shi, image: "dog", name: "ShiGuang Yu", major: "Computer Science", lang: ["javascript", "java", "c"], part: "Back End", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
                    }
                    if(self.showAlert == ShowAlert.jing){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.jing, image: "dog", name: "Jing Ma", major: "AUT Staff", lang: [""], part: "Mentor", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 110)
                    }
                    
                    ZStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Background").opacity(0.85))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                            .animation(.spring())
                        Text("Mentor")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .offset(y: -5)
                            .animation(.spring())
                    }
                    .frame(width: 110, height: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.jing, image: "dog", name: "Jing Ma", major: "", lang: "", part: "Mentor", color: Color.purple)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)
                }
                Spacer()
                TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
                    .disabled(showAlert != ShowAlert.none ? true : false)
                    .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
            }
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}

enum ShowAlert {
    case none
    case ting
    case jackie
    case shi
    case jing
}

// Old About Us Page UI
//VStack {
//    VStack {
//        TopLogoBar()
//    }
//    ScrollView{
//        ForEach (personList, id: \.self) { person in
//                Text(person.name)
//                    .foregroundColor(Color.white)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 30)
//                Image(person.image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(.horizontal, 50)
//                Text(person.personalInfo)
//                    .foregroundColor(Color.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 30)
//                    .font(.system(size: 12))
//                Divider()
//                    .background(Color.white)
//                    .frame(width: UIScreen.main.bounds.width / 1.1 , alignment: .center)
//        }
//    }
//}

//var personList : [Person] = [Person(name:"TingFung Siu", image: "dog", personalInfo: "An array is a collection of similar types of data. For example,"), Person(name: "Jackie Tin Lok Lai", image: "dog", personalInfo: "Suppose we need to record the age of 5 students. Instead of creating 5 separate variables, we can simply create an array"), Person(name: "ShiGunag Yu", image: "dog", personalInfo: "Web Server")]
