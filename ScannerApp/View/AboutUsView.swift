//
//  AboutUsView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI
import simd

struct AboutUsView: View {
    
    @State var showAlertTing = false
    @State var showAlertJackie = false
    @State var showAlertShi = false
    @State var showAlertJing = false
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                TopLogoBar()
                    .blur(radius: showAlertTing ? 30 : 0)
                    .blur(radius: showAlertJackie ? 30 : 0)
                    .blur(radius: showAlertShi ? 30 : 0)
                    .blur(radius: showAlertJing ? 30 : 0)
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
                    .blur(radius: showAlertTing ? 30 : 0)
                    .blur(radius: showAlertJackie ? 30 : 0)
                    .blur(radius: showAlertShi ? 30 : 0)
                    .blur(radius: showAlertJing ? 30 : 0)
                    
                    PersonCard(showAlert: $showAlertTing, image: "dog", name: "TingFung Siu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Front End", color: Color.blue)
                        .disabled(showAlertJackie ? true : false)
                        .disabled(showAlertShi ? true : false)
                        .disabled(showAlertJing ? true : false)
                        .blur(radius: showAlertJackie ? 30 : 0)
                        .blur(radius: showAlertShi ? 30 : 0)
                        .blur(radius: showAlertJing ? 30 : 0)
                    if(showAlertTing){
                        InfoAlertView(showAlert: $showAlertTing, image: "dog", name: "TingFung Siu", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
                    }
                    PersonCard(showAlert: $showAlertJackie, image: "dog", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Frond End & Back End", color: Color.red)
                        .disabled(showAlertShi ? true : false)
                        .disabled(showAlertTing ? true : false)
                        .disabled(showAlertJing ? true : false)
                        .blur(radius: showAlertShi ? 30 : 0)
                        .blur(radius: showAlertTing ? 30 : 0)
                        .blur(radius: showAlertJing ? 30 : 0)
                    if(showAlertJackie){
                        InfoAlertView(showAlert: $showAlertJackie, image: "dog", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End and Back End ", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
                    }
                    PersonCard(showAlert: $showAlertShi, image: "dog", name: "ShiGuang Yu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Back End", color: Color.green)
                        .disabled(showAlertJackie ? true : false)
                        .disabled(showAlertTing ? true : false)
                        .disabled(showAlertJing ? true : false)
                        .blur(radius: showAlertJackie ? 30 : 0)
                        .blur(radius: showAlertTing ? 30 : 0)
                        .blur(radius: showAlertJing ? 30 : 0)
                    if(showAlertShi){
                        InfoAlertView(showAlert: $showAlertShi, image: "dog", name: "ShiGuang Yu", major: "Computer Science", lang: ["javascript", "java", "c"], part: "Back End", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 180)
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
                    .blur(radius: showAlertTing ? 30 : 0)
                    .blur(radius: showAlertJackie ? 30 : 0)
                    .blur(radius: showAlertShi ? 30 : 0)
                    .blur(radius: showAlertJing ? 30 : 0)
                    
                    PersonCard(showAlert: $showAlertJing, image: "dog", name: "Jing Ma", major: "", lang: "", part: "Mentor", color: Color.purple)
                        .disabled(showAlertShi ? true : false)
                        .disabled(showAlertTing ? true : false)
                        .disabled(showAlertJackie ? true : false)
                        .blur(radius: showAlertTing ? 30 : 0)
                        .blur(radius: showAlertJackie ? 30 : 0)
                        .blur(radius: showAlertShi ? 30 : 0)
                    if(showAlertJing){
                        InfoAlertView(showAlert: $showAlertJing, image: "dog", name: "Jing Ma", major: "AUT Staff", lang: [""], part: "Mentor", github: URL(string: "http://www.google.com")!, linkedin: URL(string: "http://www.google.com")!, boxHeight: 110)
                    }
                }
                Spacer()
                TabBar(selectedTab: $tab.selectedTab)
                    .disabled(showAlertShi ? true : false)
                    .disabled(showAlertTing ? true : false)
                    .disabled(showAlertJackie ? true : false)
                    .disabled(showAlertJing ? true : false)
                    .blur(radius: showAlertTing ? 30 : 0)
                    .blur(radius: showAlertJackie ? 30 : 0)
                    .blur(radius: showAlertShi ? 30 : 0)
                    .blur(radius: showAlertJing ? 30 : 0)
            }
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
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
