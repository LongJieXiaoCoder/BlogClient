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
    var model: BlogItem?
    var titleHeight: CGFloat = 25.0
    var headerPadding: CGFloat = 15
    
    //MARK: 视图的初始化
    lazy var statusBarView: UIView = {
        statusBarView = UIView.init()
        statusBarView.backgroundColor = R.color.white_FFFFFF()
        return statusBarView
    }()
    
    lazy var navigationBarView: BlogContentNavigationBarView = {
        navigationBarView = BlogContentNavigationBarView(frame: CGRect.zero)
        navigationBarView.delegate = self
        return navigationBarView
    }()

    lazy var wkWebView: WKWebView = {
        wkWebView = WKWebView(frame: CGRect.zero, configuration: configuration())
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        wkWebView.addObserver(self, forKeyPath: US.keyPath.estimatedProgress, options: .new, context: nil)
        wkWebView.addObserver(self, forKeyPath: US.keyPath.title, options: .new, context: nil)
        
        wkWebView.scrollView.contentInset = UIEdgeInsets.init(top: HomePageViewCellHeadView.kHeadViewHeight + self.titleHeight + self.headerPadding, left: 0, bottom: 0, right: 0)
        wkWebView.scrollView.addSubview(titleLabel)
        wkWebView.scrollView.addSubview(headView)
        return wkWebView
    }()
    
    lazy var titleLabel: UILabel = {
        titleLabel = UILabel.lc.initLable(frame: CGRectMake(16, -(self.titleHeight + HomePageViewCellHeadView.kHeadViewHeight + self.headerPadding), kScreenWidth - 32, self.titleHeight), textColor: R.color.black_444444(), font: R.font.stHeitiSCMedium(size: 24), numberOfLines: 0)
        titleLabel.text = self.model?.title
        return titleLabel
    }()
    
    lazy var headView: HomePageViewCellHeadView = {
        headView = HomePageViewCellHeadView(frame: CGRectMake(0, -(HomePageViewCellHeadView.kHeadViewHeight), kScreenWidth, HomePageViewCellHeadView.kHeadViewHeight))
        headView.configHeadView(avatarUrl: self.model?.avatar ?? "", blogName: self.model?.author ?? "", postTime: Date.lc.timeAgoWithDate(self.model?.postDate ?? Date()), viewCount: self.model?.viewCount ?? 0)
        headView.delegate = self
        return headView
    }()

    //MARK: 实例变量
    var requestUrl: String? = nil
    var HTMLString: String? = nil

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(url: String) {
        self.init(nibName: nil, bundle: nil)
        requestUrl = url
    }
    
    convenience init(HTMLString: String, model: BlogItem) {
        self.init(nibName: nil, bundle: nil)
        self.model = model
        self.titleHeight = self.model?.title.lc.stringHeight(font: R.font.stHeitiSCMedium(size: 24), maxWidth: kScreenWidth - 32, lineSpace: 5) ?? 25
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
        self.view.backgroundColor = R.color.white_FFFFFF()
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
        self.view.addSubview(statusBarView)
        self.view.addSubview(navigationBarView)
        self.view.addSubview(wkWebView)
    }
    
    func autoLayoutView() {
        statusBarView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view).offset(0)
            make.height.equalTo(kStatusBarHeight)
        }
        
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom).offset(0)
            make.leading.trailing.equalTo(self.view).offset(0)
            make.height.equalTo(kNavigationBarContentHeight)
        }
        
        wkWebView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(0)
            make.leading.trailing.bottom.equalTo(self.view).offset(0)
        }
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

extension DisplayContentViewController: HomePageViewCellHeadViewDelegate {
    func avatarAction() {
        
    }
}

extension DisplayContentViewController: BlogContentNavigationBarViewDelegate {
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func shareAction() {
        // 要分享的内容
        let shareContent = "哈哈哈哈哈"

        // 要分享的图片
        let shareImage = R.image.nav_share_icon

        // 创建一个 UIActivityViewController 实例，指定要分享的内容和图片
        let activityViewController = UIActivityViewController(activityItems: [shareContent, shareImage], applicationActivities: nil)
        // 在 iPad 上，需要指定弹窗的位置，可以使用 barButtonItem 或者 sourceView
        activityViewController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        // 弹出分享弹窗
        self.present(activityViewController, animated: true, completion: nil)
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

