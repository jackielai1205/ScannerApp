//
//  ContentView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)
            Spacer()
            ModelView()
            Spacer()
            Button(action: {
                print("Entered")
            }, label: {
                Text("Click to start")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
