//
//  LazyView.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 15/4/2022.
//

import SwiftUI


//external code for build a view
//https://github.com/joehinkle11/Lazy-View-SwiftUI
//In swiftui, the view will be preloaded before enter the view, which will consume huge memory if preload a view contains 3D model in model list. So, this componment can help to prevent this situation. Instead of, the view only will be build when user click the view. Better performance when building the model list view

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
