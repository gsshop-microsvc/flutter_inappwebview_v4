/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 http://www.apache.org/licenses/LICENSE-2.0
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

import Flutter
import UIKit
import WebKit
import Foundation
import AVFoundation
import SafariServices

public class SwiftFlutterPlugin: NSObject, FlutterPlugin {
    
    static var instance: SwiftFlutterPlugin?
    var registrar: FlutterPluginRegistrar?
    var inAppWebViewStatic: InAppWebViewStatic?
    var myCookieManager: Any?
    var myWebStorageManager: Any?
    var credentialDatabase: CredentialDatabase?
    var inAppBrowserManager: InAppBrowserManager?
    var chromeSafariBrowserManager: ChromeSafariBrowserManager?
    
    var webViewControllers: [String: InAppBrowserWebViewController?] = [:]
    var safariViewControllers: [String: Any?] = [:]
    
    var tmpWindow: UIWindow?
    private var previousStatusBarStyle = -1
    
    public init(with registrar: FlutterPluginRegistrar) {
        super.init()
        
        self.registrar = registrar
        registrar.register(FlutterWebViewFactory(registrar: registrar) as FlutterPlatformViewFactory, withId: "com.pichillilorenzo/flutter_inappwebview")
        
        inAppBrowserManager = InAppBrowserManager(registrar: registrar)
        chromeSafariBrowserManager = ChromeSafariBrowserManager(registrar: registrar)
        inAppWebViewStatic = InAppWebViewStatic(registrar: registrar)
        if #available(iOS 11.0, *) {
            myCookieManager = MyCookieManager(registrar: registrar)
        }
        if #available(iOS 9.0, *) {
            myWebStorageManager = MyWebStorageManager(registrar: registrar)
        }
        credentialDatabase = CredentialDatabase(registrar: registrar)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        SwiftFlutterPlugin.instance = SwiftFlutterPlugin(with: registrar)
    }
}
