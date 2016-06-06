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
        
        // Request list of product
        Alamofire.request(.GET, "http://gocerebro.com/ahkl/mobytill/dbquery.php?TABLENAME=Product&FIELDS=ProductID,Name,Price,ImageURL").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                self.loadItem()
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
        
        for i in 0..<arrRes.count {
            var dict = arrRes[i]
            var nameOfItem = dict["Name"] as? String
            if (nameOfItem == "") {
                nameOfItem = "Bicycle"
            }
            
            let jsonPrice = dict["Price"] as! String
            var price = jsonPrice
            if (jsonPrice == "") {
                price = "80"
            }
            let itemImage = UIImage(named: "Product2")
            let firstItem = Item(name: nameOfItem!, photo: itemImage, price: price)!
            
            items.append(firstItem)
        }
        
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        
        let item: Item
//        if searchController.active && searchController.searchBar.text != "" {
//            item = filteredMeals[indexPath.row]
//        } else {
//            item = items[indexPath.row]
//        }
        item = items[indexPath.row]
        
        cell.itemName?.text = item.name
        cell.itemPrice?.text = "RM \(item.price)"
        cell.itemImage?.image = item.photo
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ItemDetails" {
            let itemDetailViewController = segue.destinationViewController as! ItemDetailsViewController
            if let selectedMealCell = sender as? ItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let item : Item
                item = items[indexPath.row]
                itemDetailViewController.item = item
            }
        }
        else if segue.identifier == "AddItem" {
            print("Add a new meal")
        }
    }
}
