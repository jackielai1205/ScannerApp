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
                
                if camera.isTaken{
                    HStack{
                        Spacer()
                        Button(action:{
                            if camera.isTaken {camera.reTake()}
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .clipShape(Circle())
                        })
                            .padding(.top, UIScreen.main.bounds.height/15)
                            .padding(.trailing, UIScreen.main.bounds.width/15)
                    }
                }
                
                Spacer()
                HStack{
                    if camera.isTaken{
                        Button(action: {
                            if camera.isTaken {camera.savePic()}
                        }, label: {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                            .padding(.bottom, UIScreen.main.bounds.height/3.5)
                            .padding(.leading, UIScreen.main.bounds.width/15)
                        Spacer()
                        
                    }else{
                        Button(action: {
                            if !camera.isTaken {
                                camera.takePic()
                            }
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
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(
            perform: {
            camera.checkAuthorization()
        })
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var output = AVCapturePhotoOutput()
    @Published var isSaved = false
    @Published var picData = Data(count:0)
    
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
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                self.isTaken.toggle()
            }
        }
    }
    
    func reTake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                self.isTaken.toggle()
                self.isSaved = false;
            }
        }
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        print("Photo taken")
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        
        self.picData = imageData
    }
    
    func savePic(){
        let image = UIImage(data:self.picData)!
        
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

        camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
