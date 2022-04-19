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
    @State var queryStatus:StatusMonitor
    @EnvironmentObject var tab:TabSettings
    @State var isPresented = false;
    
    init(){
        UITableView.appearance().showsVerticalScrollIndicator = false
        if let data = UserDefaults.standard.string(forKey: "Save") {
            uploadID = data
        }else{
            uploadID = UUID().uuidString
        }
        UITableView.appearance().backgroundColor = .clear
        queryStatus = StatusMonitor(status: false, message: "Somethings error.. Please reopen the application")
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
                self.queryStatus = await self.manager.checkDetails(uploadID: self.uploadID)
                if(!self.queryStatus.status){
                    isPresented = true
                }
            }
            .task {
                self.queryStatus = await self.manager.checkDetails(uploadID: self.uploadID)
                if(!self.queryStatus.status){
                    isPresented = true
                }
            }
            .alert(self.queryStatus.message, isPresented: $isPresented){
                Button("OK", role: .cancel){}
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
    
    func checkDetails(uploadID:String)async ->StatusMonitor {
        
        var catchedError = false
        
        guard let url = URL(string: "http://192.168.1.204:8080/query") else {return StatusMonitor(status: false, message: "Can't find the website.")}
        print(url)
        let body: [String:String] = ["deviceID": uploadID]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
            guard let data = data else {
                catchedError = true
                return
            }

            
            let outputData = try! JSONDecoder().decode([ModelDetail].self, from: data)
            
            DispatchQueue.main.async {
                self.finalData = outputData
            }
        }
        task.resume();
        if(catchedError){
            return StatusMonitor(status: false, message: "Can't fetch the data")
        }else{
            return StatusMonitor(status: true, message: "test")
        }
    }
}

class StatusMonitor{
    @State var status:Bool
    @State var message:String
    
    init(status:Bool, message:String){
        self.status = status
        self.message = message
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
