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
    @EnvironmentObject var tab:TabSettings
    @State var flashLightSwitch = false
    var style = StrokeStyle(lineWidth: 2,
                            lineCap: .round,
                            lineJoin: .miter,
                            miterLimit: 0,
                            dash: [2, 4],
                            dashPhase: 0)
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                    HStack{
                        Spacer()
                        Button(action: {
                            flashLightSwitch.toggle()
                            camera.toggleTorch(on: flashLightSwitch)
                        }, label: {
                            ZStack{
                                Circle()
                                    .stroke(style: style)
                                
                                Image(systemName: "bolt")
                            }
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.yellow)
                        })
                        .padding(30)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/8)
                CameraPreview(camera: camera)
                ZStack(alignment:.center){
                    Rectangle()
                        .fill(Color.black)
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
                        })
                        .padding(.top, 20)
                        TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
                            .ignoresSafeArea()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4.4)
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
    
    
    
    //Check the permission of camera and seek if don't have
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
    
    //Set up camera
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
    
    //Toggle the flashlight of camera
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    //Capture pic
    func takePic(){
        DispatchQueue.global(qos:.background).async {
            print("Take Pic")
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            DispatchQueue.main.async {
                self.isTaken.toggle()
            }
        }
    }
    
    //Check output
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        print("Photo taken")
        
        if(error == nil){
            guard let imageData = photo.fileDataRepresentation() else {return}
            self.savePic(imageData: imageData)
        }
        
        print(error ?? "")

    }
    
    //Save pic to gallery
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

        camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
