//
//  SubmitForm.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 15/4/2022.
//

import SwiftUI

struct UploadModelForm: View {
    @Binding var isShowing: Bool
    @Binding var images : [UIImage]
    @Binding var userID : String
    @Binding var picker: Bool
    @Binding var cancel : Bool
    @State var isPresentMessage = false
    @State var modelName = ""
    @State var message = ""
    @State var isLoading = false
    @State var response:PostResponse?

    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Background"))
                .opacity(0.85)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .ignoresSafeArea()
            VStack(alignment: .center){
                HStack{
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Enter Model Name Here...", text: $modelName)
                    }
                    .underlineTextField()
                    .padding(.leading, 30)
                    Button(action: {
                        self.isShowing = true
                    }, label: {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(Color.black)
                            .padding()
                    })
                }
                Spacer()
                ZStack(alignment:.center){
                    GeometryReader { geometry in
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(images,id:\.self){
                                    img in
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .frame(width: geometry.size.width)
                                        .frame(height: geometry.size.height)
                                }
                            }
                        }
                    }
                    .opacity(!images.isEmpty ? 1 : 0)
                    .offset(x: !images.isEmpty ? 0 : 2000)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                            .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height / 15, alignment: .center)
                            .opacity(0.85)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        Label("No Image Selected", systemImage: "questionmark.circle")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight:.bold))
                    }
                    .offset(x: !images.isEmpty ? -2000 : 0)
                    .opacity(!images.isEmpty ? 0 : 1)
                }
                Spacer()
                HStack{
                    Button(action: {
                        if(!images.isEmpty && modelName != ""){
                            isLoading = true
                            let form = createUploadMultiPartForm(images: images, userID: userID, modelName: modelName)
                            submitPostMultiPartForm(form: form, domain: "post")
                            isLoading = false
                            self.message = "Images uploaded"
                            self.isPresentMessage = true
                            withAnimation(.linear){
                                images = []
                                modelName = ""
                            }
                        }else if(images.isEmpty){
                            self.message = "Please select images"
                            self.isPresentMessage = true
                        }else if(modelName == ""){
                            self.message = "Please enter model name"
                            self.isPresentMessage = true
                        }
                    }, label: {
                        Text("Upload")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, maxHeight: 60,alignment: .center)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                    Button(action: {
                        picker.toggle()
                    }, label: {
                        Text("Select")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, maxHeight: 60,alignment: .center)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                    Button(action: {
                        withAnimation(.linear){
                            cancel = true
                            images = []
                        }
                    }, label: {
                        Text("Clear")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, maxHeight: 60,alignment: .center)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                }
                .padding(.bottom , 10)
                .padding(.horizontal, 5)
            }
        }
        .disabled(isLoading)
        .padding(.top, 20)
        .alert(message, isPresented: $isPresentMessage){
            Button("OK"){}
        }
    }
}

extension Color {
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.black)
            .padding(10)
    }
}


struct SubmitForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}
