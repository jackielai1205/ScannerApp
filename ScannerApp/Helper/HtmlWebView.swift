//
//  ModelListItem.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 21/4/2022.
//

import SwiftUI
import WebKit

struct ModelListItem: UIViewRepresentable{
    
    let htmlFileName: String
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let filePath = Bundle.main.path(forResource: "index", ofType: "html") else {
            return print("Error file path")
        }
        let url = URL(fileURLWithPath: filePath)
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}

//extension WKWebView{
//    func load (_ htmlFileName: String){
//
//
//        guard !htmlFileName.isEmpty else {
//            return print("Empty file name")
//        }
//
//        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
//            return print("Error file path")
//        }
//
//        let url = URL(fileURLWithPath: filePath)
//
//        do{
//            let htmlString = try String(contentsOfFile: filePath, encoding:.utf8)
//            loadHTMLString(htmlString, baseURL: url)
//        }catch{
//            print("Error")
//        }
//
//        let bundleMainUrl = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "www");
//        let fullUrl = URL(string: "?os=ios", relativeTo: bundleMainUrl);
//        let request = URLRequest(url: fullUrl!);
//        webView?.load(request);
//    }
//}

struct HtmlWebView: View {
    var body: some View {
        ModelListItem(htmlFileName: "index")
    }
}

struct HtmlWebView_Previews: PreviewProvider {
    static var previews: some View {
        HtmlWebView()
    }
}
