//
//  MultiPartFormData.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 10/4/2022.
//

import MultipartForm
import UIKit

func createMultiPartForm(images:[UIImage], identification:String) -> MultipartForm{
    
    
    var currentImage:Data? = nil
    var form = MultipartForm(parts: [])
    form.parts.append(MultipartForm.Part(name:"verifier", value: identification))
    for index in 0..<images.count{
        currentImage = images[index].jpegData(compressionQuality: 0.8)
        if (currentImage != nil){
            form.parts.append(MultipartForm.Part(name: "filetoupload[]", data: currentImage!, filename: "\(index).jpeg", contentType: "image/jpeg"))
        }
    }
    return form
}

func submitMultiPartForm(form:MultipartForm){
    let session = URLSession.shared
    var request = URLRequest(url: URL("http://192.168.1.204:8080/fileupload"))
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
