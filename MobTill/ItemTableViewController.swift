//
//  ItemTableViewController.swift
//  MobTill
//
//  Created by Masrina on 04/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import Alamofire
import UIKit
import SwiftyJSON


class ItemTableViewController: UITableViewController {

    var items = [Item]()
    var arrRes = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()

        // Request list of product
        Alamofire.request(.GET, "http://gocerebro.com/ahkl/mobytill/dbquery.php?TABLENAME=Product&FIELDS=ProductID,Name,Price,ImageURL").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }

    func loadItem(){
        let itemImage = UIImage(named: "item1")
        let firstItem = Item(name: "Sample Item", photo: itemImage, price: "RM 85")!
        
        items += [firstItem, firstItem, firstItem]
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        
//        let item: Item
//        if searchController.active && searchController.searchBar.text != "" {
//            item = filteredMeals[indexPath.row]
//        } else {
//            item = items[indexPath.row]
//        }
//        item = items[indexPath.row]
        
        var dict = arrRes[indexPath.row]
        
        let nameOfItem = dict["Name"] as? String
        if (nameOfItem == "") {
            cell.itemName?.text = "Bicycle"
        } else {
            cell.itemName?.text = nameOfItem
        }
        cell.itemImage?.image = UIImage(named: "item1")
        let price = dict["Price"] as! String
        if (price == "") {
            cell.itemPrice?.text = "RM 80"
        } else {
            cell.itemPrice?.text = "RM \(price)"
        }
        return cell
    }
}
