//
//  MultiPartFormData.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 10/4/2022.
//

import MultipartForm
import UIKit

//Construct a multipart form
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


//Submit it to the server
func submitPostMultiPartForm(form:MultipartForm, domain:String){
    let session = URLSession.shared
    
    guard let url = URL(string: "http://192.168.1.204:8080/fileupload") else {
        print("Error URL")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue(form.contentType, forHTTPHeaderField: "Content-Type")
    let task = session.uploadTask(with: request, from: form.bodyData)
    task.resume()
}
