//
//  WebViewController.swift
//  SampleiOSApp
//
//  Created by Ku Ku on 2/5/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView!
    var linkUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
    }
    
    fileprivate func setUpWebView(){
        // loading URL :
        let url = NSURL(string: linkUrl)
        let request = NSURLRequest(url: url! as URL)
        
        // init and load request in webview.
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.view.addSubview(webView)
        self.view.sendSubviewToBack(webView)
        
    }

}

extension WebViewController:WKNavigationDelegate{
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
