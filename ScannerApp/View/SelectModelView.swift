//
//  ViewModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 14/4/2022.
//

import SwiftUI
import SceneKit

struct SelectModelView: View {
    
    @State var fileName = ""
    @State var openFile = false
    @State var model = Model(id: 0, modelName: "")
    @State var fileURL = ""
    @State var view = SCNScene(named: "dragon.usdz")
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack{
            // Set background color to Image(Background)
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                TopLogoBar()
                    // Import file function, only allow user to select .usdz file
                    .fileImporter(isPresented: $openFile, allowedContentTypes: [.usdz]) {  result in
                        switch result {
                        // If select file success, get usdz file name from file path and set view to current 3D model
                        case .success(let url):
                            _ = url.startAccessingSecurityScopedResource()
                            fileURL = url.absoluteString
                            self.fileName = url.lastPathComponent
                            model.modelName = fileName
                            do{
                                try
                                view = SCNScene(url: url, options: .none)
                            }catch{
                                print(error)
                            }
                        // If select file failure, print out error message
                        case.failure(let error):
                            print(error)
                        }
                    }
                ZStack{
                    // Set background color to Image(Background)
                    Color("Background").opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    VStack{
                        // Function to display current 3D model
                        SceneView(scene: view , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 1.9)
                            .cornerRadius(20)
                            .padding(.top, 10)
                        HStack {
                            // Click Me button to allow user import .usdz file
                            Button {
                                openFile.toggle()
                            } label: {
                                HStack{
                                    Image(systemName: "cursorarrow.rays")
                                    Text("Click Me !")
                                        .fontWeight(.bold)
                                }
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                            }
                            .frame(width: 150, height: 50)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 10)
                            
                            // Back button which back to ModelListView
                            NavigationLink(destination: LazyView(ModelListView()), label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                    .frame(width: 150, height: 50)
                                    .padding(.top, 10)
                                    .overlay(
                                        HStack{
                                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                            Text("Back")
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                        }
                                            .padding(.top, 10)
                                            .frame(width: 150, height: 50)
                                            .foregroundColor(Color.white)
                                    )
                            })
                            
                        }
                    }
                }
                // Hide the default navigation view back button
                .navigationBarBackButtonHidden(true)
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.55)
                .cornerRadius(30)
                .padding(.top, 10)
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

struct SelectModelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectModelView()
    }
}
