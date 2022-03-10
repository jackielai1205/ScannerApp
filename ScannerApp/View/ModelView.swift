//
//  ModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI
import SceneKit

struct ModelView: View {
    
    @State var dragon = Model(id: 1, modelName: "dragon.usdz")
    @State var chair = Model(id: 0, modelName: "chair.usdz")
    
    var body: some View {
        
        VStack{
            SceneView(scene: SCNScene(named: dragon.modelName) , options: [.autoenablesDefaultLighting,.allowsCameraControl])
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            Spacer();
        }
    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
    }
}
