//
//  HttpAuth.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 19/4/2022.
//

import Foundation

class HttpAuth: ObservableObject{
    
    var didChange = PassthroughSubject<HttpAuth, Never>()
    @Published var finalData:[ModelDetail] = []
    var authenticated = false{
        didSet{
            didChange.send(self)
        }
    }
    
    func checkDetails(uploadID:String)async {
        
        guard let url = URL(string: "http://192.168.1.204:8080/query") else {return}
        print(url)
        let body: [String:String] = ["deviceID": uploadID]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
            guard let data = data else {
                return
            }

            
            let outputData = try! JSONDecoder().decode([ModelDetail].self, from: data)
            
            DispatchQueue.main.async {
                self.finalData = outputData
            }
        }
        task.resume();
    }
}
