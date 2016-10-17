//
//  WebPreviewingViewController.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class WebPreviewingViewController: UIViewController,UIWebViewDelegate {

    var myWebView: UIWebView?
    
    var webProgress: HK_WebProgress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webProgress = HK_WebProgress()
        webProgress?.frame = CGRect(x: 0.0, y: 64.0, width: SCREEN_WIDTH, height: 3)
        view.layer.addSublayer(webProgress!)
        
        myWebView = UIWebView.init(frame: CGRect(x: 0.0, y: (webProgress?.frame.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-(webProgress?.frame.maxY)!))
        myWebView?.allowsLinkPreview = true // 要实现3DTouch，必须为true
        view.addSubview(myWebView!)
        myWebView?.delegate = self
        
        webLoadDataSource()
    
    }
    
    func webLoadDataSource() {
        weak var weakSelf = self
        DispatchQueue.global().async {
            
            do {
                let loadDate: Data = try Data.init(contentsOf: URL(string: "https://www.baidu.com")!)
                
                weakSelf?.myWebView?.load(loadDate, mimeType: "text/html", textEncodingName: "text/html", baseURL: URL(string: "https://www.baidu.com")!)
                
            } catch let error {
                print("error = \(error)")
            }
            
        }
    }
  
    // MARK: -- UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(#function)
        webProgress?.startLoad()
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print(#function)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(#function)
        webProgress?.finishedLoad()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(#function)
        webProgress?.finishedLoad()
    }
}
