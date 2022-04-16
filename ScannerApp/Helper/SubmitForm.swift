//
//  SubmitForm.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 15/4/2022.
//

import SwiftUI

struct SubmitForm: View {
    
    @Binding var isShowing: Bool
    @Binding var images : [UIImage]
    @Binding var uploadID : String
    @Binding var picker: Bool
    @Binding var cancel : Bool
    @State var message:String = "Somethings Wrong... Please try again"
    @State var isPresentMessage = false

    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Background"))
                .opacity(0.85)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .ignoresSafeArea()
            VStack(alignment: .center){
                HStack{
                    Spacer()
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
                        Label(" No Image Selected", systemImage: "questionmark.circle")
                            .foregroundColor(Color.white)
                            .font(.title)
                    }
                    .offset(x: !images.isEmpty ? -2000 : 0)
                    .opacity(!images.isEmpty ? 0 : 1)
                }
                Spacer()
                HStack{
                    Button(action: {
                        if(!images.isEmpty){
                            let form = createMultiPartForm(images: images, identification: uploadID)
                            submitMultiPartForm(form: form)
                            self.message = "Images Uploaded."
                            self.isPresentMessage = true
                            print("Upload")
                        }else{
                            self.message = "No Image Selected."
                            self.isPresentMessage = true
                            print("No pics")
                        }
                    }, label: {
                        Text("Upload")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, maxHeight: 60,alignment: .center)
                            .background(Color.gray)
                            .clipShape(Capsule())
                    })
                    .alert(self.message, isPresented: $isPresentMessage){
                        Button("OK", role: .cancel){
                            withAnimation(.easeOut){
                                self.images = []
                            }
                        }
                    }
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
                    .disabled(cancel)
                }
                .padding(.bottom , 10)
                .padding(.horizontal, 5)
            }
        }
        .padding(.top, 20)
    }
}


struct SubmitForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadModelView()
    }
}
