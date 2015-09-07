//
//  SidePanelViewController.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/18/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    func menuItemSelected(menu: String)
}

class SidePanelViewController: UITableViewController {
    
    var delegate: SidePanelViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.backgroundColor = UIColor.blackColor()
        tableView.backgroundColor = UIColor.orangeColor()
        tableView.separatorColor = UIColor.redColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menu = ["favorites", "tophit"]
        delegate.menuItemSelected(menu[indexPath.row])
    }

}
