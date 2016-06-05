//
//  CheckoutViewController.swift
//  MobTill
//
//  Created by Masrina on 04/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class CheckoutViewController: UIViewController, UITableViewDataSource {
    
    var shareURL: NSString!
    var lists: Results<SelectedItems>!
    let uiRealm = try! Realm()
    
    @IBOutlet weak var checkoutTableView: UITableView!
    
    @IBAction func shareLink(sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [self.shareURL as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://gocerebro.com/ahkl/mobytill/GenPaymentLink.php?MODE&MERCHANTID=MOLWallet_Dev1&AMOUNT=20.00&ORDERID=123456&BILL_NAME=Ainoor&BILL_EMAIL=Ainoor@test.com&BILL_MOBILE=01345675&DESC=SAMPLE&COUNTRY=my&VKEY=c6c5cdaabf772a366e1b5ba8a512afac", parameters: nil)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    self.shareURL = response.result.value
                    print("Share URL: \(self.shareURL)")
                case .Failure(let error):
                    print("Error: \(error)")
                }
        }
        retrieveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveData() {
        
        lists = uiRealm.objects(SelectedItems)
        self.checkoutTableView.setEditing(false, animated: true)
        self.checkoutTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CheckOutCellId"
        
        let cell = checkoutTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CheckoutTableViewCell
        let list = lists[indexPath.row]
        
        cell.productName.text = list.itemName
        cell.productImage.image = UIImage(named: "item1")
        cell.totalQuantity.text = list.quantity
        cell.totalPrice.text = list.totalPrice
        
//        let item: Item
//        item = items[indexPath.row]
//        
//        cell.itemName?.text = item.name
//        cell.itemImage?.image = item.photo
//        cell.itemPrice?.text = item.price
        
        return cell
    }
}
