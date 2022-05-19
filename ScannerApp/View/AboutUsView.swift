//
//  AboutUsView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI
import simd

struct AboutUsView: View {
    
    // showAlert >> different alert message box when click to check individual profile information
    @State var showAlert = ShowAlert.none
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack {
            // Set background color to Image(Background)
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                // Logo bar positing at the top of page
                // >> blur = 20 when showing different person's profile message box
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
                    
                    // Each PersonCard represent a person, PersonCard can be click to see more info about that person
                    // >> blur = 20 when showing another person's profile message box
                    // >> Clicking function will disable when showing another person's profile message box
                    PersonCard(showAlert: $showAlert, type: ShowAlert.ting, image: "tingprofile", name: "TingFung Siu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Front End", color: Color.blue)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)
                    
                    // Once PersonCard is clicked, person's profile message box will show by calling InfoAlertView
                    if(self.showAlert == ShowAlert.ting){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.ting, image: "tingprofile", name: "TingFung Siu", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End", github: "https://github.com/typist95616", linkedin: "https://www.linkedin.com/in/walter-siu-1095281a5/", boxHeight: 180)
                    }
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.jackie, image: "jackieprofile", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Full Stack", color: Color.red)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)

                    if(self.showAlert == ShowAlert.jackie){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.jackie, image: "jackieprofile", name: "Jackie Tin Lok Lai", major: "Computer Science", lang: ["swiftui", "javascript", "java", "c"], part: "Front End and Back End ", github: "https://github.com/jackielai1205", linkedin: "https://www.linkedin.com/in/jackie-tin-lok-lai-3b2813228/", boxHeight: 180)
                    }
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.shi, image: "shiprofile", name: "ShiGuang Yu", major: "Computer Science", lang: "Swift Java JavaScript C", part: "Back End", color: Color.green)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)

                    if(self.showAlert == ShowAlert.shi){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.shi, image: "dog", name: "ShiGuang Yu", major: "Computer Science", lang: ["javascript", "java", "c"], part: "Back End", github: "https://github.com/Lutr1z", linkedin: "https://www.linkedin.com/feed/", boxHeight: 180)
                    }
                    if(self.showAlert == ShowAlert.jing){
                        InfoAlertView(showAlert: $showAlert, type: ShowAlert.jing, image: "jingprofile", name: "Jing Ma", major: "AUT Staff", lang: [""], part: "Mentor", github: "", linkedin: "", boxHeight: 110)
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
                    
                    PersonCard(showAlert: $showAlert, type: ShowAlert.jing, image: "jingprofile", name: "Jing Ma", major: "", lang: "", part: "Mentor", color: Color.purple)
                        .blur(radius: (showAlert != ShowAlert.none) ? 20 : 0)
                        .disabled(showAlert != ShowAlert.none ? true : false)
                }
                Spacer()
                
                // Tab Bar positing at the bottom of page
                // >> blur = 20 when showing any person's profile message box
                // >> Clicking function will disable when showing any person's profile message box
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

// Enum class for showing different profile alert message box
// When showAlert == none >> nothing show
// When showAlert == ting >> ting's profile message box show.. etc
enum ShowAlert {
    case none
    case ting
    case jackie
    case shi
    case jing
}
