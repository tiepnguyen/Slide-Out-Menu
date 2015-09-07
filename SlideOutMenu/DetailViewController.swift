//
//  DetailViewController.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/18/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailWebView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var address: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = address[0]
        
        let url = NSURL(string: address[1])
        detailWebView.loadRequest(NSURLRequest(URL: url!))
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        let title = detailWebView.stringByEvaluatingJavaScriptFromString("document.title")
        navigationItem.title = title
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        // UIAlertView(title: "Cannot Connect", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
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
