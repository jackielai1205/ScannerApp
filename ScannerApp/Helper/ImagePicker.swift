//
//  ImagePicker.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 4/4/2022.
//

import SwiftUI
import PhotosUI
import UIKit


struct ImagePicker : UIViewControllerRepresentable {    
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    
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

        var isExisted = false
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
                            print(err)
                            return
                        }
//                        for currenImage in 0..<self.parent.image.count{
//                            if self.parent.image[currenImage].isEqualToImage(image as! UIImage){
//                                self.isExisted = true;
//                            }
//                        }
                        if(self.isExisted == false){
                            self.parent.image.append(image as! UIImage)
                        }
                    }
                }else{
                    print("cannot be loaded")
                }
            }
        }
    }
}

extension UIImage {

    func isEqualToImage(_ image: UIImage) -> Bool {
        let data1 = self.pngData()
        let data2 = image.pngData()
        return data1 == data2
    }
}
