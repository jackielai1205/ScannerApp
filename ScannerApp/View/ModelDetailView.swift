//
//  ViewModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 14/4/2022.
//

import SwiftUI
import SceneKit

struct ModelDetailView: View {
    
    @EnvironmentObject var tab:TabSettings
    @State var model:TransactionsData
    @State var isPresentDeleteMessage:Bool = false
    @State var isDisplay: Bool = false
    @State var serverResponse:DeletResponse? = nil
    @State var displayMessage = ""
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                TopLogoBar()
                    .ignoresSafeArea()
                HtmlWebView()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Background")
                            .opacity(0.85))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .padding(.horizontal,10)
                        .padding(.bottom,10)
                    VStack(spacing: 5){
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray)
                            Text("Model Detail")
                                .font(Font.title3.bold())
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: 30)
                        ModelInfoRow(description: "Model ID:", sfImage: "info.circle", data: String(model.tranID))
                        Divider()
                        ModelInfoRow(description: "Model Name:", sfImage: "car", data: model.modelName)
                        Divider()
                        ModelInfoRow(description: "Receive Time", sfImage: "clock.badge.checkmark", data: model.date)
                        Divider()
                        HStack{
                            Button(action: {
                                isPresentDeleteMessage = true
                            }, label: {
                                BackButton(labelText: "Delete")
                            })
                            NavigationLink(destination: LazyView(ModelListView()), label: {
                                BackButton(labelText: "Back")
                            })
                        }
                        
                    }
                }
            }
            .alert("Do you want to detele the model?", isPresented: $isPresentDeleteMessage){
                Button("Yes"){
                    Task{
                        serverResponse = await deleteModel(tranID: model.tranID) ?? nil
                        if(serverResponse == nil){
                            displayMessage = "Can't receive data"
                        }
                        else if(serverResponse!.code != 0 && serverResponse!.message != ""){
                            displayMessage = serverResponse!.message
                        }else{
                            displayMessage = "Model Deleted"
                        }
                        isDisplay = true
                    }
                }
                Button("No"){print("Clicked No")}
            }
            .alert(displayMessage, isPresented: $isDisplay){
                Button("OK"){}
            }
            .navigationBarHidden(true)
        }
    }
}

func deleteModel(tranID:Int, completion: @escaping (DeletResponse?) -> Void) {
    print("Delete Model: \(String(tranID))")
    let requestHeaders:[String:String] = ["Content-Type" : "application/x-www-form-urlencoded"]
    
    
    var requestBodyComponents = URLComponents()
    requestBodyComponents.queryItems = [URLQueryItem(name: "tranID", value: String(tranID))]
    var request = URLRequest(url: URL(string: "http://47.101.40.95/delete_model")!)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = requestHeaders
    request.httpBody = requestBodyComponents.query?.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        
        if let responseData = data {
            if let result = try? JSONDecoder().decode(DeletResponse.self, from: responseData){
                completion(result)
            }else{
                completion(nil)
            }
        }
    }
    task.resume()
}

func deleteModel(tranID:Int) async -> DeletResponse?{
    await withCheckedContinuation{
        continuation in
        deleteModel(tranID: tranID, completion: {
            response in
            continuation.resume(returning: response)
        })
    }
}


struct ModelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ModelDetailView(model: TransactionsData(tranID: 1, userID: "12313132", date: "2022-4-4", modelName: "Chair", status: 0))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

struct BackButton : View{
    
    @State var labelText:String
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.gray)
            Text(labelText)
                .foregroundColor(Color.white)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding()
    }
}


//let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//
//    guard let responseData = data else {
//        print("Error: did not receive data")
//        return
//    }
//
//    let decoder = JSONDecoder()
//    do {
//        serverResponse = try decoder.decode(DeletResponse.self, from: responseData)
//        print(serverResponse)
//    } catch {
//        print("error trying to convert data to JSON")
//    }
//}
//task.resume()
