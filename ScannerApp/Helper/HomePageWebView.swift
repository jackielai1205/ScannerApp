//
//  WebView.swift
//  ScannerApp
//
//  Created by Walter Siu on 14/4/2022.
//

import SwiftUI
import WebKit

struct HomePageWebView: UIViewRepresentable {

    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct HomePageWebView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageWebView(url: URL(string: "http://www.google.com")! )
    }
}
