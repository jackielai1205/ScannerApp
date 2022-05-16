//
//  HomePageModelCard.swift
//  ScannerApp
//
//  Created by Walter Siu on 16/5/2022.
//

import SwiftUI
import SceneKit

struct HomePageModelCard: View{
    
    @State var isDisplay = false
    @Binding var page: Int
    var width: CGFloat
    var data: Type
    
    var body: some View{
        
        ZStack{
            VStack{
                NavigationView{
                    VStack{
                        Text(self.data.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Image(self.data.image)
                            .resizable()
                            .cornerRadius(20)
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3)
                        
                        Text("Photo Number: " + self.data.photoNum)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(.top, 1)
                                            
                        Text("Process Time: " + self.data.time + " mins")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                            .fontWeight(.bold)
                            .padding(.top, 1)
                        
                        Button {
                            isDisplay.toggle()
                        } label: {
                            Text("Click Me")
                                .fontWeight(.bold)
                        }
                        .frame(width: 100, height: 30)
                        .background(Color.white)
                        .foregroundColor(Color("Background"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 1)
                        .sheet(isPresented: $isDisplay) {
                            ZStack{
                                Rectangle()
                                    .fill(Color("Background"))
                                    .ignoresSafeArea()
                                VStack{
                                    SceneView(scene: SCNScene(named: data.model) , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                                        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.4, alignment: .center)
                                        .cornerRadius(20)
                                    Button(action: {
                                        isDisplay.toggle()
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.gray)
                                            .frame(width: 150, height: 50)
                                            .overlay(
                                                HStack{
                                                    Image(systemName: "arrowshape.turn.up.backward.fill")
                                                    Text("Back")
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 20))
                                                }
                                                .frame(width: 150, height: 50)
                                                .foregroundColor(Color.white)
                                            )
                                    })
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .background(Color("Background").opacity(0.85))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                }
                .frame(width: UIScreen.main.bounds.width / 1.35, height: UIScreen.main.bounds.height / 1.9, alignment: .center)
                .cornerRadius(30)
            }
            .frame(width: self.width)
        }
    }
}
