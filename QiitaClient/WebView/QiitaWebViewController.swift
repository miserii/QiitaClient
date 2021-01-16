//
//  WebViewController.swift
//  QiitaClient
//
//  Created by osakamiseri on 2021/01/17.
//

import UIKit
import WebKit

class QiitaWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var qiitaWebView: WKWebView!
    private var url: URL!

    static func instantiate(url: URL) -> QiitaWebViewController {
        let vc = UIStoryboard(name: "QiitaWebViewController", bundle: nil).instantiateInitialViewController() as! QiitaWebViewController
        vc.url = url
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        qiitaWebView.load(URLRequest(url: url))
    }
}

