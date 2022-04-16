//
//  HomePageView.swift
//  ScannerApp
//
//  Created by Walter Siu on 11/3/2022.
//

import SwiftUI
import SceneKit

struct HomePageView: View {
    
    @State var startAnimation = false
    @State var photoNumber:String = ""
    @State var renderTime:String = ""
    @State var rate:String = ""
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack {
            Color("Background")
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                TopLogoBar()
                ScrollView {
                    VStack {
                        HStack{
                            SceneView(scene: SCNScene(named: "dragon.usdz") , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                                .padding(.leading, 10)
                                .padding(.top, 5)
                            VStack{
                                Text(photoNumber).animation(.spring())
                                Text(renderTime).animation(.spring())
                                Text(rate).animation(.spring())
                                Button {
                                    startAnimation.toggle()
                                } label: {
                                    
                                    Text("Model Info")
                                        .foregroundColor(Color.black)
                                }
                            }
                            .frame(width: 200, height: 200)
                            .onChange(of: startAnimation) { _ in
                            renderAnimation(startAnimation: startAnimation)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3, alignment: .leading)
                    }
                    SceneView(scene: SCNScene(named: "dragon.usdz") , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                        .padding(.leading, 10)
                        .padding(.top, 5)
                    SceneView(scene: SCNScene(named: "dragon.usdz") , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                        .padding(.leading, 10)
                        .padding(.top, 5)
                    SceneView(scene: SCNScene(named: "dragon.usdz") , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 3)
                        .padding(.leading, 10)
                        .padding(.top, 5)
                }
                TabBar(selectedTab: $tab.selectedTab)
            }
        }
    }
    
    func renderAnimation(startAnimation: Bool){
        if (startAnimation) {
            photoNumber = ""
            "Photos number: 196".enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05){
                        photoNumber += String(character)

                }
            }
                renderTime = ""
            "Render Time: Around 40 mins".enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 + Double(index) * 0.05){
                        renderTime += String(character)
                }
            }
                rate = ""
            "Perfect Rate: 90%".enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5 + Double(index) * 0.05){
                        rate += String(character)
                }
            }
        } else {
            photoNumber = ""
            renderTime = ""
            rate = ""
        }
    }
}






struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
