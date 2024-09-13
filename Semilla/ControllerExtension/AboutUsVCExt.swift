//
//  AboutUsVCExt.swift
//  Semilla
//
//  Created by Netset on 06/12/23.
//

import UIKit
import WebKit

extension AboutUsVC: DelegatesAboutUs {
    
    // MARK: - Button Back Clicked
    func gotoBack() {
        self.popViewController(true)
    }
   
}

extension AboutUsVC : WKNavigationDelegate {
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("didFinish Url :- ",webView.url?.absoluteString ?? "")
        CommonMethod.shared.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(#function,"completionHandler")
        completionHandler(.performDefaultHandling,nil)
    }
}
