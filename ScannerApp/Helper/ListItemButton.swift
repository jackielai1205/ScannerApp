//
//  ListItemButton.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/5/2022.
//

import SwiftUI

struct ListItemButton: View {
    
    @State var model:TransactionsData
    @State var serverResponse:DeletResponse? = nil
    @Binding var isDisplay:Bool
    @Binding var displayMessage:String
    
    var body: some View {
        if(model.status == 1){
            ZStack{
                Button(action: {}, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Download"))
                        Label("View Model", systemImage: "arrow.down.circle")
                             .font(.system(size: 16, weight: .bold, design: .rounded))
                             .padding(3)
                             .foregroundColor(Color.black)
                    }
                })
                .disabled(true)
            }
            .background( NavigationLink("", destination: ModelDetailView(model: model)).opacity(0))
        }else{
            ZStack{
                Button(action: {
                    Task{
                        let serverResponse = await deleteModel(tranID: model.tranID)
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
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                        Label("Delete Model", systemImage: "xmark.circle")
                             .font(.system(size: 16, weight: .bold, design: .rounded))
                             .foregroundColor(Color.black)
                             .padding(3)
                    }
                })
            }
        }
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

    
    func deleteModel(tranID:Int, completion: @escaping (DeletResponse?) -> Void) {
        print("Delete Model: \(String(tranID))")
        
        let requestHeaders:[String:String] = ["Content-Type" : "application/x-www-form-urlencoded"]
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [URLQueryItem(name: "tranID", value: String(tranID))]
        var request = URLRequest(url: URL(string: "http://192.168.1.204:8080/delete_model")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let responseData = data {
                if let result = try? JSONDecoder().decode(DeletResponse.self, from: responseData){
                    print(result)
                    completion(result)
                }else{
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}

