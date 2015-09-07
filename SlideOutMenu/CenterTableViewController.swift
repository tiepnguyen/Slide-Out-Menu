//
//  CenterTableViewController.swift
//  SlideOutMenu
//
//  Created by Tiep Nguyen on 12/18/14.
//  Copyright (c) 2014 Tiep Nguyen. All rights reserved.
//

import UIKit

class CenterTableViewController: UITableViewController {
    
    var itemList = [
        ["Tinh Te", "http://tinhte.vn"],
        ["VNExpress", "http://vnexpress.net"],
        ["Sports Daily", "http://sportsdaily.vn"],
        ["9GAG", "http://9gag.com"]
    ]
    
    var program: String?
    
    var statusBarHidden = false
    
    var selectedItem: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(program)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let item = itemList[indexPath.row]
        cell.textLabel?.text = item[0]
        cell.detailTextLabel?.text = item[1].stringByReplacingOccurrencesOfString("http://", withString: "", options: nil, range: nil)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedItem = itemList[indexPath.row]
        performSegueWithIdentifier("list_detail", sender: nil)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "list_detail" {
            let detailVC = segue.destinationViewController as DetailViewController
            detailVC.address = selectedItem
        }
    }
    
    @IBAction func refreshButtonAction(sender: UIBarButtonItem) {
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.flashStatus()
    }

}
