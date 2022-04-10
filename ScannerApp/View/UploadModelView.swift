//
//  UploadModelView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 17/3/2022.
//

import SwiftUI
import PhotosUI

struct UploadModelView: View {
    
    @State var images : [UIImage] = []
    @State var picker = false;
    
    var body: some View {
        
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                if(!images.isEmpty){
                    ScrollView(.horizontal,showsIndicators: false, content: {
                        HStack(spacing:15){
                            ForEach(images,id:\.self){
                                img in
                                Image(uiImage: img)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 45, height: 250)
                                    .cornerRadius(20)
                            }
                        }
                    })
                }
                HStack{
                    Button(action: {
                        if(!images.isEmpty){
                            print("Upload")
                        }else{
                            print("No pics")
                        }

                    }, label: {
                        Text("Upload")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 35)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                    Button(action: {
                        picker.toggle()
                    }, label: {
                        Text("Pick images")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 35)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                    Button(action: {
                       images = []
                    }, label: {
                        Text("Clear")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 35)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                }
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

