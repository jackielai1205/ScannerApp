//
//  ModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 12/5/2022.
//

import SwiftUI
import SceneKit

struct ModelView: View {
    
    @State var model:TransactionsData
    @State var view:SCNScene? = nil
    
    var body: some View {
        VStack{
            if(view != nil){
                SceneView(scene: view, options: [.autoenablesDefaultLighting, .allowsCameraControl])
            }else{
                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                        .blur(radius: 20)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(3)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .task {
            do{
                await try loadModel()
                DispatchQueue.main.async {
                    let filePath = getDocumentsDirectory().appendingPathComponent(String(model.tranID) + ".usdz")
                    do{
                        view = try SCNScene(url: filePath);
                    }catch{
                        print("err")
                    }

                    print(filePath)
                    print(view)
                }
            }catch{
                print("err")
            }
        }
    }
    
    func loadModel() async throws{
        let url = URL(string: "http://192.168.1.204:8080/download/?file=\(model.location)")
        print(url)
        let request = URLRequest(url: url!)
        let requestHeaders:[String:String] = ["Content-Type" : "application/x-www-form-urlencoded"]
        var requestBodyComponents = URLComponents()
//        requestBodyComponents.queryItems = [URLQueryItem(name: "tranID", value: String(model.tranID))]
         let result:Int = try await withCheckedThrowingContinuation{
            continuation in
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                if(error != nil){
                    continuation.resume(throwing: error!)
                    return
                }
                
                do{
                    try data?.write(to: getDocumentsDirectory().appendingPathComponent(String(model.tranID) + ".usdz"))
                    continuation.resume(returning: 0)
                }catch let error{
                    print("Can't write data")
                    continuation.resume(throwing: error)
                }
                print(data)
                
            }
            task.resume()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

//struct ModelView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModelView(model: TransactionsData(tranID: 41, userID: "!23131", location: "!@313", date: "12/May/2022", modelName: "123", status: 0))
//    }
//}
