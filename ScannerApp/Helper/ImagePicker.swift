//
//  ImagePicker.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 4/4/2022.
//

import SwiftUI
import PhotosUI
import UIKit


//Image picker for import images from local device
struct ImagePicker : UIViewControllerRepresentable {    
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    @Binding var cancel: Bool
    @Binding var image : [UIImage]
    @Binding var picker: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {

        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate{

        var parent : ImagePicker
        init(parent1: ImagePicker){
            parent = parent1
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            parent.picker.toggle()
            
            for img in results{
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    img.itemProvider.loadObject(ofClass: UIImage.self){
                        (image, err) in
                        guard let image = image else{
                            return
                        }
                        //No more 80 pics upload to app, otherwise causes memory leak
                        if self.parent.cancel == false && self.parent.image.count <= 80{
                            self.parent.image.append(image as! UIImage)
                        }
                    }
                }else{
                    print("cannot be loaded")
                }
            }
            self.parent.cancel = false
        }
    }
}
