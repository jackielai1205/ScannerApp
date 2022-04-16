//
//  ModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 7/3/2022.
//

import SwiftUI
import Combine

struct ModelView: View {
    
    @State var uploadID:String
    @StateObject var manager = HttpAuth()
    @EnvironmentObject var tab:TabSettings
    
    init(){
        if let data = UserDefaults.standard.string(forKey: "Save") {
            uploadID = data
        }else{
            uploadID = UUID().uuidString
        }
        UITableView.appearance().backgroundColor = .clear
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
                    List{
                        ForEach(self.manager.finalData, id:\.self){
                            data in
//                            NavigationLink(destination: {
//                                LazyView(
//                                    ViewModelView()
//                                )
//                            }, label: {
//                                ListItem(model: data)
//                            })
                            ListItem(model: data)
                                .listRowSeparatorTint(Color.black)
                        }.listRowBackground(Color("Background")
                            .opacity(0.85)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        
                        )
                    }
                    TabBar(selectedTab: $tab.selectedTab)
                }
                .ignoresSafeArea()
            }
            .refreshable {
                await self.manager.checkDetails(uploadID: self.uploadID)
            }
            .task {
                await self.manager.checkDetails(uploadID: self.uploadID)
            }
        }
    }
}

class HttpAuth: ObservableObject{
    
    var didChange = PassthroughSubject<HttpAuth, Never>()
    @Published var finalData:[ModelDetail] = []
    var authenticated = false{
        didSet{
            didChange.send(self)
        }
    }
    
    func checkDetails(uploadID:String) async{
        guard let url = URL(string: "http://192.168.1.204:8080/query") else {return}
        print(url)
        let body: [String:String] = ["deviceID": uploadID]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){(data,response,error) in
        guard let data = data else {return}
        let outputData = try! JSONDecoder().decode([ModelDetail].self, from: data)
            DispatchQueue.main.async {
                self.finalData = outputData
            }
        }.resume()
    }
}

extension URL {
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
    }
}
