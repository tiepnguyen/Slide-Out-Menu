//
//  StatusViewController.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/26/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20)
        view.backgroundColor = UIColor.orangeColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
