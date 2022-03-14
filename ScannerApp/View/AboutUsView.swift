//
//  AboutUsView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI

struct AboutUsView: View {
    
    var personList : [Person] = [Person(name:"TingFung Siu", image: "dog", personalInfo: "An array is a collection of similar types of data. For example,"), Person(name: "Jackie Tin Lok Lai", image: "dog", personalInfo: "Suppose we need to record the age of 5 students. Instead of creating 5 separate variables, we can simply create an array"), Person(name: "ShiGunag Yu", image: "dog", personalInfo: "Web Server")]
    
    var body: some View {
        ZStack {
            Color("Background")
            ScrollView {
                VStack {
                    TopLogoBar()
                }
                VStack{
                    ForEach (personList, id: \.self) { person in
                            Text(person.name)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                            Image(person.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 50)
                            Text(person.personalInfo)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 30)
                                .font(.system(size: 12))
                            Divider()
                                .background(Color.white)
                                .frame(width: UIScreen.main.bounds.width / 1.1 , alignment: .center)
                    }
                }
                .frame(height: UIScreen.main.bounds.height*1.3,alignment: .top)
            }
        }
        .ignoresSafeArea()
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
