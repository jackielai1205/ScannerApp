//
//  UploadModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 17/3/2022.
//

import SwiftUI
import PhotosUI
import MultipartForm

struct UploadModelView: View {
    
    @State var uploadID:String
    @State var images : [UIImage] = []
    @State var picker = false;
    
    
    init(){
        if let data = UserDefaults.standard.string(forKey: "Save") {
            uploadID = data
        }else{
            uploadID = UUID().uuidString
        }
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(uploadID, forKey: "Save")
    }
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                TopLogoBar()
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Background"))
                        .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height/1.55)
                        .padding(.top, 40)
                        .opacity(0.85)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                }
                Spacer()
            }
            .sheet(isPresented: $picker, content: {
                ImagePicker(image: $images, picker: $picker)
            })
        }
    }
}


struct UploadModelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UploadModelView()
        }
    }
}




//if(!images.isEmpty){
//    ScrollView(.horizontal,showsIndicators: false, content: {
//        HStack(spacing:15){
//            ForEach(images,id:\.self){
//                img in
//                Image(uiImage: img)
//                    .resizable()
//                    .frame(width: UIScreen.main.bounds.width - 45, height: 250)
//                    .cornerRadius(20)
//            }
//        }
//    })
//}
//Button(action: {
//    if(!images.isEmpty){
//        let form = createMultiPartForm(images: images, identification: uploadID)
//        submitMultiPartForm(form: form)
//        print("Upload")
//    }else{
//        print("No pics")
//    }
//
//}, label: {
//    Text("Upload")
//        .foregroundColor(.white)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 35)
//        .background(Color.gray)
//        .clipShape(Capsule())
//})
//Button(action: {
//    picker.toggle()
//}, label: {
//    Text("Pick images")
//        .foregroundColor(.white)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 35)
//        .background(Color.gray)
//        .clipShape(Capsule())
//})
//Button(action: {
//   images = []
//}, label: {
//    Text("Clear")
//        .foregroundColor(.white)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 35)
//        .background(Color.gray)
//        .clipShape(Capsule())
//})
