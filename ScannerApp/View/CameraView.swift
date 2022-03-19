//
//  CameraView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 11/3/2022.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        
        ZStack{
            CameraPreview(camera: camera)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Button(action: {
                        camera.takePic()
                }, label: {
                    ZStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)

                        Circle()
                            .stroke(Color.white, lineWidth:4)
                            .frame(width: 70, height: 70)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height / 3.3)
                })
                .frame(height: 75)
            }
        }
        .onAppear(
            perform: {
            camera.checkAuthorization()
        })
    }
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var output = AVCapturePhotoOutput()
    @Published var isSaved = false
    
    func checkAuthorization(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){
                (status) in
                
                if status{
                    self.setUp()
                }
            }
            
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func setUp(){
        do{
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    func takePic(){
        DispatchQueue.global(qos:.background).async {
            print("Take Pic")
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                self.isTaken.toggle()
            }
        }
    }
    
    func reTake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            print("Session started")
            DispatchQueue.main.async {
                self.isTaken.toggle()
                self.isSaved = false;
            }
        }
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        print("Photo taken")
        
        if(error == nil){
            guard let imageData = photo.fileDataRepresentation() else {return}
            self.savePic(imageData: imageData)
        }
        
        print(error ?? "")

    }
    
    func savePic(imageData:Data){
        let image = UIImage(data:imageData)!
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        print("saved Successfully...")
    }
}


struct CameraPreview: UIViewRepresentable {

    @ObservedObject var camera:CameraModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)

        //camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
