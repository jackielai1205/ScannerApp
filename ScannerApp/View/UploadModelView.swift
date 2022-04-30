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
    @State var picker = false;
    @State var images:[UIImage] = []
    @State var cancel = false
    @State var isShowing = false
    @EnvironmentObject var tab:TabSettings
    
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
                UploadModelForm(isShowing: $isShowing, images: $images, userID: $uploadID, picker: $picker, cancel: $cancel)
                    .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 1.5)
                Spacer()
                TabBar(selectedTab: $tab.selectedTab, isShowed: $tab.isShowing)
            }
            .sheet(isPresented: $picker, content: {
                ImagePicker(cancel: $cancel, image: $images, picker: $picker)
            })
            InstructionView(isShowing: $isShowing)
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
