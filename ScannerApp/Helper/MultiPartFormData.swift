//
//  MultiPartFormData.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 10/4/2022.
//

import MultipartForm
import UIKit

func createUploadMultiPartForm(images:[UIImage], userID:String, modelName:String) -> MultipartForm{

    var currentImage:Data? = nil
    var form = MultipartForm(parts: [])
    form.parts.append(MultipartForm.Part(name: "modelName", value: modelName))
    form.parts.append(MultipartForm.Part(name:"userID", value: userID))
    for index in 0..<images.count{
        currentImage = images[index].jpegData(compressionQuality: 0.8)
        form.parts.append(MultipartForm.Part(name: "image", data: currentImage!, filename: "\(index).jpeg", contentType: "image/jpeg"))
    }
    print(form)
    return form
}


func submitPostMultiPartForm(form:MultipartForm, domain:String){
    let session = URLSession.shared
    
    guard let url = URL(string: "http://47.101.40.95/\(domain)") else {
        print("Error URL")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue(form.contentType, forHTTPHeaderField: "Content-Type")
    let task = session.uploadTask(with: request, from: form.bodyData)
    task.resume()
}



//swift
//import MultipartForm
//
//let form = MultipartForm(parts: [
//    MultipartForm.Part(name: "a", value: "1"),
//    MultipartForm.Part(name: "b", value: "2"),
//    MultipartForm.Part(name: "c", data: imageData, filename: "3.png", contentType: "image/png"),
//])
//
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//request.setValue(form.contentType, forHTTPHeaderField: "Content-Type")
//
//let task = session.uploadTask(with: request, from: form.bodyData)
//task.resume()
