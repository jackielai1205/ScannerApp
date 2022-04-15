//
//  ViewModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 14/4/2022.
//

import SwiftUI
import SceneKit

struct ViewModelView: View {
    
    @State var dragon = Model(id: 1, modelName: "dragon.usdz")
    @State var fileName = ""
    @State var openFile = false
    @State var model = Model(id: 0, modelName: "")
    @State var fileURL = ""
    @State var view = SCNScene(named: "chair.usdz")
    @State private var textInFiles = [String]()
    
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
                        print(url)
                        fileURL = url.absoluteString
                        self.fileName = url.lastPathComponent
                        print(fileName)
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
                SceneView(scene: view , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                VStack {
                    Button {
                        openFile.toggle()
                    } label: {
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 2)
                            .background(Circle().foregroundColor(Color(red: 66/255, green: 180/255, blue: 157/255)))
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 2.5, alignment: .top)
                            .overlay(Text("Select Model")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold))
                            .offset(y: -(UIScreen.main.bounds.height / 9))
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ViewModelView_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelView()
    }
}
