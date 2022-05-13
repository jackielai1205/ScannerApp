//
//  HomePageWebView.swift
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
        webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: HomePageWebView
        
        init(_ parent: HomePageWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
                guard let serverTrust = challenge.protectionSpace.serverTrust else { return completionHandler(.useCredential, nil) }
                let exceptions = SecTrustCopyExceptions(serverTrust)
                SecTrustSetExceptions(serverTrust, exceptions)
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            }
    }
}

//extension WKNavigationDelegate{
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//            guard let serverTrust = challenge.protectionSpace.serverTrust else { return completionHandler(.useCredential, nil) }
//            let exceptions = SecTrustCopyExceptions(serverTrust)
//            SecTrustSetExceptions(serverTrust, exceptions)
//            completionHandler(.useCredential, URLCredential(trust: serverTrust))
//        }
//}

struct HomePageWebView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageWebView(url: URL(string: "http://www.google.com")! )
    }
}
