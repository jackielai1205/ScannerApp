//
//  PageController.swift
//  ScannerApp
//
//  Created by Walter Siu on 16/5/2022.
//

import SwiftUI

struct PageController: UIViewRepresentable{
    
    @Binding var page: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = .green
        view.pageIndicatorTintColor = UIColor.white
        view.numberOfPages = data.count
        view.currentPage = page
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        
        DispatchQueue.main.async {
            uiView.currentPage = self.page
        }
    }
}
