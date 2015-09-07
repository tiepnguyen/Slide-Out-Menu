//
//  SecondaryViewController.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/27/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

class SecondaryViewController: UIViewController, UIWebViewDelegate {
    
    var program: String?

    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(program)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        webview.loadRequest(NSURLRequest(URL: NSURL(string: "http://tinhte.vn")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
