//
//  ViewModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 14/4/2022.
//

import SwiftUI
import SceneKit

struct SelectModelView: View {
    
    @State var dragon = Model(id: 1, modelName: "dragon.usdz")
    @State var fileName = ""
    @State var openFile = false
    @State var model = Model(id: 0, modelName: "")
    @State var fileURL = ""
    @State var view = SCNScene(named: "dragon.usdz")
    @State private var textInFiles = [String]()
    @EnvironmentObject var tab:TabSettings
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                TopLogoBar()
                .fileImporter(isPresented: $openFile, allowedContentTypes: [.usdz]) {  result in
                    switch result {
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
                    case.failure(let error):
                        print(error)
                    }
                }
                ZStack{
                    Color("Background").opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    VStack{
                        SceneView(scene: view , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 1.9)
                                        .cornerRadius(20)
                                        .padding(.top, 10)
                        VStack {
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
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 1.55)
                .cornerRadius(30)
                .padding(.top, 10)
                Spacer()
                TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
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
