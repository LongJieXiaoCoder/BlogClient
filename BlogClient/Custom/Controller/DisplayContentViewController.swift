//
//  DisplayContentViewController.swift
//  BlogClient
//
//  Created by Long on 2020/5/27.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import WebKit

class DisplayContentViewController: UIBaseViewController {
    var statusBarView: UIView! = nil
    var wkWebView: WKWebView! = nil
    var requestUrl: String? = nil
    var HTMLString: String? = nil

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(url: String) {
        self.init(nibName: nil, bundle: nil)
        requestUrl = url
    }
    
    convenience init(HTMLString: String) {
        self.init(nibName: nil, bundle: nil)
        self.HTMLString = HTMLString
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        wkWebView.removeObserver(self, forKeyPath: US.keyPath.estimatedProgress, context: nil)
        wkWebView.removeObserver(self, forKeyPath: US.keyPath.title, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.view.showHUD()
        
        if let urlStr = requestUrl {
            guard let encodingUrl = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            guard let url = URL(string: encodingUrl) else { return }
            let request = URLRequest.init(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
            wkWebView.load(request)
        } else if let HTMLStr = HTMLString {
            wkWebView.loadHTMLString(HTMLStr, baseURL: nil)
        }
    }
}

// MARK: - InitViewProtocol
extension DisplayContentViewController: InitViewProtocol {
    func initView() {
        statusBarView = UIView.init()
        statusBarView.backgroundColor = R.color.white_FFFFFF()
        self.view.addSubview(statusBarView)
        
        // wkwebview
        wkWebView = initWKWebView()
        self.view.addSubview(wkWebView)
    }
    
    func autoLayoutView() {
        statusBarView.mas_makeConstraints { (make) in
            make?.leading.trailing()?.top()?.mas_equalTo()(self.view)?.offset()(0)
            make?.height.mas_equalTo()(kStatusBarHeight)
        }
        wkWebView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(statusBarView.mas_bottom)?.offset()(0)
            make?.leading.trailing()?.bottom()?.mas_equalTo()(self.view)?.offset()(0)
        }
    }
    
    func initWKWebView() -> WKWebView {
        let wkWebView = WKWebView(frame: CGRect.zero, configuration: configuration())
        
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        
        wkWebView.addObserver(self, forKeyPath: US.keyPath.estimatedProgress, options: .new, context: nil)
        wkWebView.addObserver(self, forKeyPath: US.keyPath.title, options: .new, context: nil)
        return wkWebView
    }
    
    func configuration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.processPool = WKProcessPool()
        configuration.allowsInlineMediaPlayback = true
        configuration.userContentController = userContentController()
        return configuration
    }
    
    func userContentController() -> WKUserContentController {
        let userContentController = WKUserContentController()
//        let source: String = "var meta = document.createElement('meta');" + "meta.name = 'viewport';" + "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" + "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";
//        let userScript: WKUserScript = WKUserScript(source: source, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
//        userContentController.addUserScript(userScript)
        return userContentController
    }
}

extension DisplayContentViewController {
    func postJs(_ url: URLConvertible, params: String) -> String {
        let postFunc =
                  """
                        function post(path, params) {
                        var method = "post";
                        var form = document.createElement("form");
                        form.setAttribute("method", method);
                        form.setAttribute("action", path);

                        for(var key in params) {
                            if(params.hasOwnProperty(key)) {
                                var hiddenField = document.createElement("input");
                                hiddenField.setAttribute("type", "hidden");
                                hiddenField.setAttribute("name", key);
                                hiddenField.setAttribute("value", params[key]);

                                form.appendChild(hiddenField);
                            }
                        }
                        document.body.appendChild(form);
                        form.submit();
                        }
                    """
        
        let js = "\(postFunc)post(\(url),\(params))"
        return js
    }
}

// MARK: - KVO
extension DisplayContentViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let kp = keyPath else { return }
        
        if kp == US.keyPath.estimatedProgress {
            if let ch = change {
                let progress = ch[.newKey] as? Double
                if let pg = progress {
                    // 当前的进度
                    
                }
            }
        } else if kp == US.keyPath.title {
            if let ch = change {
                guard let title = ch[.newKey] as? String else { return }
                // 可以设置网页的标题
                
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension DisplayContentViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        log("didReceiveServerRedirectForProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.view.hideHUD()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.hideHUD()
        
        let str = """
                    var script = document.createElement('script');
                    script.type = 'text/javascript';
                    script.text = function ResizeImages() {
                        var myimg,oldwidth;
                        var maxwidth = %f;
                        for(i=0;i <document.images.length;i++){
                            myimg = document.images[i];
                            if(myimg.width > maxwidth) {
                                oldwidth = myimg.width;
                                myimg.width = %f;
                            }
                        }
                    };
                    document.getElementsByTagName('head')[0].appendChild(script);
                  """
        
        let js = "\(str)\(kScreenWidth)\(kScreenWidth - 15)"
        webView.evaluateJavaScript(js, completionHandler: nil)
        webView.evaluateJavaScript("ResizeImages();", completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.hideHUD()
    }
 
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        log("AuthChallengeDisposition")
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let card = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, card)
        } else {
            completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
        }
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        self.view.hideHUD()
    }
}

// MARK: - WKUIDelegate
extension DisplayContentViewController: WKUIDelegate {
    
}

