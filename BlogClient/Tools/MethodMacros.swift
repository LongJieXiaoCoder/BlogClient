//
//  MethodMacros.swift
//  BlogClient
//
//  Created by Long on 2020/5/9.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

//MARK: - 常用常量
let kAppBundleIdentifier = Bundle.main.bundleIdentifier ?? ""
let kStatusBarHeight: CGFloat = isIPhoneXSeries() ? (isSupportDynamicIsland() ? 55 : 44) : 20
let kNavigationBarHeight: CGFloat = isIPhoneXSeries() ? (isSupportDynamicIsland() ? 99 : 88) : 64
let kBottomTabBarHeight: CGFloat = isIPhoneXSeries() ? 34+49 : 49
let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width    // 暂只支持竖屏
let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height

let kAppLanguage: Array = LanguageManager.share.appLanguage


// MARK: - Log
func log<T>(_ msg: T, file: NSString = #file, line: Int = #line, fn: String = #function) {
    #if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix, msg)
    #endif
}

// MARK: - Array
func isArray(_ value: Any) -> Bool {
    value is [Any]
}

func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}

// MARK: - 机型判断
func isSupportDynamicIsland() -> Bool {
    var isSupport = false
    let deviceModel = UIDevice.deviceModel()
    if deviceModel.count <= 0 {
        return isSupport
    }
    
    if deviceModel == "iPhone15,2" || deviceModel == "iPhone15,3" {
        //iPhone15,2 - iPhone14 Pro
        //iPhone15,3 - iPhone14 Pro Maxs
        isSupport = true
    }
    return isSupport
}

func isIPhoneXSeries() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        let maxLength = screenWidth > screenHeight ? screenWidth : screenHeight
        if  maxLength == 780.0 ||
            maxLength == 812.0 ||
            maxLength == 896.0 ||
            maxLength == 844.0 ||
            maxLength == 926.0 ||
            maxLength == 852.0 ||
            maxLength == 932.0 {
            return true
        }
    }
    return false
}

func isIphone6() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        let maxLength = screenWidth > screenHeight ? screenWidth : screenHeight
        if maxLength == 667.0 {
            return true
        }
    }
    return false
}

func isIphone6P() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        let maxLength = screenWidth > screenHeight ? screenWidth : screenHeight
        if maxLength == 736.0 {
            return true
        }
    }
    return false
}

// MARK: - HTML模板
func ContentHTMLTemplateWithArgs(titleFontSize: CGFloat, titleFontColor: String, timeFontSize: CGFloat, timeFontColor: String, bodyFontSize: CGFloat, bodyFontColor: String, title: String, time: String, body: String) -> String {
    """
    <html>
       <head>
           <meta charset=\"utf-8\">
           <meta name=\"viewport\" content=\"width=device-width,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;\" />
           <meta id=\"vp\" name=\"viewport\" content=\"width=device-width, user-scalable=no,maximum-scale=1.0,initial-scale=1\" />
           <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />
           <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />
           <meta name=\"format-detection\" content=\"telephone=no\" />
           <style type=\"text/css\">
               p.normal {font-weight: normal; font-size: \(titleFontSize); color: \(titleFontColor); font-family: sans-serif;}
               p.thick {font-weight: lighter; font-size: \(timeFontSize); color: \(timeFontColor); font-family: sans-serif;}
               body {font-size: \(bodyFontSize); color: \(bodyFontColor); font-family: sans-serif;}
           </style>
            <script type='text/javascript'>
            window.onload = function(){
            var maxwidth = document.body.clientWidth;
            for(i=0; i<document.images.length;i++) {
                var myimg = document.images[i];
                if(myimg.width > maxwidth) {
                    myimg.style.width = '100%';
                    myimg.style.height = 'auto';
                }
            }
            }
            </script>
       </head>
       <body>
       <p><p class=\"normal\">\(title)</p>
       <p><p class=\"thick\">\(time)</p>
       \(body)
       </body>
    </html>
    """
}



