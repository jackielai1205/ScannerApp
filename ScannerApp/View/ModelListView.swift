//
//  ModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI
import Combine

struct ModelListView: View {
    
    @State var uploadID:String
    @State private var result:QueryUserResponse = QueryUserResponse()
    @EnvironmentObject var tab:TabSettings
    @State var isDisplay = false
    @State var displayMessage = ""
    
    init(){
        UITableView.appearance().showsVerticalScrollIndicator = false
        if let data = UserDefaults.standard.string(forKey: "Save") {
            uploadID = data
        }else{
            uploadID = UUID().uuidString
        }
        UITableView.appearance().backgroundColor = .clear
        print(uploadID)
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(uploadID, forKey: "Save")
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    TopLogoBar()
                        .padding(.bottom, 20)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Background"))
                            .opacity(0.85)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 50)
                                NavigationLink(destination: LazyView(SelectModelView()), label: {
                                    Label("Select your local .usdz model here", systemImage: "hand.tap")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 15, weight: .bold))
                                })
                            }
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(Color.gray)
                                .overlay(
                                    Image(systemName: "arrowtriangle.right")
                                        .foregroundColor(Color.white)
                                )
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 10)
                    List{
                        if result.code == 0 && result.trans.count > 0{
                            ForEach(result.trans, id:\.self){
                                data in
                                ListItem(model: data, isDisplay: $isDisplay, displayMessage: $displayMessage)
                                    .listRowSeparatorTint(Color.black)
                            }.listRowBackground(Color("Background")
                                .opacity(0.85)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10))
                        }else{
                            NoRecordFoundView()
                                .frame(height: UIScreen.main.bounds.height / 8)
                                .listRowBackground(Color("Background")
                                    .opacity(0.85)
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10))
                        }
                    }
                    TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
                }
                .ignoresSafeArea()
            }
            .alert(displayMessage, isPresented: $isDisplay){
                Button("OK"){
                    Task{
                        await loadData(uploadID: self.uploadID)
                    }
                }
            }
            .refreshable {
                await loadData(uploadID: self.uploadID)
            }
            .task {
                await loadData(uploadID: self.uploadID)
            }
        }
        .navigationBarHidden(true)
    }
    
    func loadData(uploadID:String)async {
        
        let requestHeaders:[String:String] = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [URLQueryItem(name: "userID", value: uploadID)]
        var request = URLRequest(url: URL(string: "http://192.168.1.204:8080/query_user")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    result = try decoder.decode(QueryUserResponse.self, from: responseData)
                    print(result)
                } catch {
                    print("error trying to convert data to JSON")
                }
            }
        }
        task.resume()
    }
}

struct ModelListView_Previews: PreviewProvider {
    static var previews: some View {
        ModelListView()
    }
}
