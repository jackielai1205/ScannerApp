//
//  HomePageCarousel.swift
//  ScannerApp
//
//  Created by Walter Siu on 16/5/2022.
//

import SwiftUI

struct HomePageCarousel : UIViewRepresentable{
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        return HomePageCarousel.Coordinator(parent1: self)
    }
    
    var width : CGFloat
    var height : CGFloat
    @Binding var page : Int
    
    func makeUIView(context: Context) -> UIScrollView  {
        let total = width * CGFloat(data.count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = context.coordinator
        
        let view1 = UIHostingController(rootView: HomePageWebList(page: self.$page))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        view1.view.backgroundColor = .clear
        view.addSubview(view1.view)
        return view
    }
    
    class Coordinator : NSObject, UIScrollViewDelegate{
        
        var parent: HomePageCarousel
        
        init(parent1: HomePageCarousel){
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            self.parent.page = page
        }
    }
}
