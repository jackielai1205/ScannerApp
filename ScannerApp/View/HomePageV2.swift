////
////  HomePageV2.swift
////  ScannerApp
////
////  Created by Walter Siu on 12/4/2022.
////
//
//import SwiftUI
//import WebKit
//
//struct HomePageV2: View {
//
//    @State var menu = 0
//    @State var page = 0
//    @EnvironmentObject var tab:TabSettings
//
//    var body: some View {
//
//        ZStack{
//            Image("Background")
//                .resizable()
//                .ignoresSafeArea();
//            VStack{
//                TopLogoBar();
//                VStack{
//                    GeometryReader { x in
//                        Carousel(width: UIScreen.main.bounds.width, page: self.$page, height: x.frame(in: .global).height)
//                    }
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
//                    PageControl(page: self.$page)
//                    Spacer()
//                    TabBar(selectedTab: $tab.selectedTab)
//                }
//            }
//        }
//    }
//}
//
//struct WebList: View{
//
//    @Binding var page: Int
//
//    var body: some View{
//        HStack(spacing: 0){
//            ForEach(data){ i in
//                Card(url: URL(string: "http://www.google.com")!, page: self.$page, width: UIScreen.main.bounds.width, data: i)
//            }
//        }
//    }
//}
//
//struct Card: View{
//
//    @State var url: URL
//    @State var showWeb = false
//    @Binding var page: Int
//    var width: CGFloat
//    var data: Type
//
//    var body: some View{
//
//        ZStack{
////            Color("Background")
////                .opacity(0.85)
////                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
//            VStack{
//                NavigationView{
//                    VStack{
//                        Text(self.data.name)
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .foregroundColor(Color.white)
//
//                        Image(self.data.image)
//                            .resizable()
//                            .cornerRadius(20)
//                            .scaledToFit()
//                            .opacity(1)
//                            .frame(width: self.width - 50, height: 300)
//
//                        Text("Photo Number: " + self.data.photoNum)
//                            .font(.headline)
//                            .foregroundColor(Color.white)
//                            .fontWeight(.bold)
//                            .padding(.top, 2)
//
//                        Text("Process Time: " + self.data.time + " min")
//                            .font(.headline)
//                            .foregroundColor(Color.white)
//
//                            .fontWeight(.bold)
//                            .padding(.top, 2)
//
//
//                        Button {
//                            showWeb.toggle()
//                        } label: {
//                            Text("Click Me")
//                                .fontWeight(.bold)
//                        }
//                        .frame(width: 100, height: 30)
//                        .background(Color.white)
//                        .foregroundColor(Color("Background"))
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .padding(.top, 2)
//                        .sheet(isPresented: $showWeb) {
////                            WebView(url: self.url)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 25)
//                    .navigationTitle("")
//                    .navigationBarHidden(true)
//                    .background(Color("Background").opacity(0.85))
//                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
//                }
//                .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 1.85, alignment: .center)
//                .cornerRadius(30)
//            }
//            .frame(width: self.width)
//        }
//    }
//}
//
//struct Carousel : UIViewRepresentable{
//
//    func makeCoordinator() -> Coordinator {
//        return Carousel.Coordinator(parent1: self)
//    }
//
//    var width : CGFloat
//    @Binding var page : Int
//    var height : CGFloat
//
//    func makeUIView(context: Context) -> UIScrollView  {
//        let total = width * CGFloat(data.count)
//        let view = UIScrollView()
//        view.isPagingEnabled = true
//        view.contentSize = CGSize(width: total, height: 1.0)
//        view.bounces = true
//        view.showsVerticalScrollIndicator = false
//        view.showsHorizontalScrollIndicator = false
//        view.delegate = context.coordinator
//
//        let view1 = UIHostingController(rootView: WebList(page: self.$page))
//        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
//        view1.view.backgroundColor = .clear
//        view.addSubview(view1.view)
//        return view
//    }
//
//    func updateUIView(_ uiView: UIScrollView, context: Context) {
//
//    }
//
//    class Coordinator : NSObject, UIScrollViewDelegate{
//
//        var parent: Carousel
//
//        init(parent1: Carousel){
//          parent = parent1
//        }
//
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
//            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
//            self.parent.page = page
//        }
//    }
//}
//
//struct PageControl: UIViewRepresentable{
//
//    @Binding var page: Int
//
//    func makeUIView(context: Context) -> UIPageControl {
//        let view = UIPageControl()
//        view.currentPageIndicatorTintColor = .green
//        view.pageIndicatorTintColor = UIColor.white
//        view.numberOfPages = data.count
//        view.currentPage = page
//        return view
//    }
//
//    func updateUIView(_ uiView: UIPageControl, context: Context) {
//
//        DispatchQueue.main.async {
//
//            uiView.currentPage = self.page
//        }
//    }
//
//}
//
//struct Type: Identifiable{
//    var id: Int
//    var name: String
//    var photoNum: String
//    var time: String
//    var image: String
//    var model: String
//}
//
//var data = [
//    Type(id: 0, name: "Dragon", photoNum: "196", time: "30", image: "dragon", model: "dragon.usdz"),
//    Type(id: 1, name: "Chair", photoNum: "20", time: "4", image: "Chair", model: "chair.usdz"),
//    Type(id: 2, name: "Bottle", photoNum: "20", time: "3", image: "bottle", model: "chair.usdz")
//]
//
//struct HomePageV2_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageV2()
//    }
//}
//
//
