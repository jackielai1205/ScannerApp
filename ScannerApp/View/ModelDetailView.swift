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
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Background")
                            .opacity(0.85))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .padding(.horizontal,10)
                    VStack(alignment: .center){
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray)
                            Text("Model Detail")
                                .font(Font.title3.bold())
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: 30)
                        ModelView(model: model)
                            .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: UIScreen.main.bounds.height / 2.5)
                            .padding(.horizontal)
                        VStack(alignment:.leading){
                            ModelInfoRow(description: "Model ID:", sfImage: "info.circle", data: String(model.tranID))
                            Divider()
                            ModelInfoRow(description: "Model Name:", sfImage: "car", data: model.modelName)
                            Divider()
                            ModelInfoRow(description: "Receive Data:", sfImage: "calendar.circle", data: model.date)
                            Divider()
                            ModelInfoRow(description: "Images Number:", sfImage: "clock", data: String(model.imageLength))
                            Divider()
                            ModelInfoRow(description: "Process Time:", sfImage: "forward.circle", data: model.processTime ?? "Waiting to Process")
                        }
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


//Query to server and convert the response to client
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

//Complmention handler to convert data when the server connection ended
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
        ModelDetailView(model: TransactionsData(tranID: 1, userID: "12313132", location: "123", date: "2022-4-4", time: "12:30", modelName: "Chair", status: 0, processTime: "1505", imageLength: 4))
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
