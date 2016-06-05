//
//  ItemDetailsViewController.swift
//  MobTill
//
//  Created by Ainor Syahrizal on 04/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var detailScrollView: UIScrollView!
    var shareURL: NSString!
    var item: Item?
    let uiRealm = try! Realm()
    var totalPayPrice: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemDetailsViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemDetailsViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        self.hideKeyboardWhenTappedAround()
        if let item = item {
            itemImage.image = item.photo
            itemName.text = item.name
            itemPrice.text = "RM \(item.price)"
            itemDescription.text = "An electrical cable is made of two or more wires running side by side and bonded, twisted, or braided together to form a single assembly, the ends of which can be connected to two devices, enabling the transfer of electrical signals from one device to the other."
            itemDescription.font = UIFont(name: "Helvetica", size: 14)
        }
        
        self.requestShareURL()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        
        let newItemSelected = SelectedItems()
        newItemSelected.itemName = itemName.text!
        newItemSelected.itemPrice = itemPrice.text!
        newItemSelected.quantity = quantityTextField.text!
        
        var str = itemPrice.text
        let strArr = str!.characters.split{$0 == " "}.map(String.init)
        
        for item in strArr {
            let components = item.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            let part = components.joinWithSeparator("")
            
            if let intVal = Int(part) {
                str = String(intVal)
                print("this is a number -> \(intVal)")
            }
        }
        
        var qty = quantityTextField.text
        let strArr2 = qty!.characters.split{$0 == " "}.map(String.init)
        
        for item in strArr2 {
            let components = item.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            let part = components.joinWithSeparator("")
            
            if let intVal = Int(part) {
                qty = String(intVal)
                print("this is a number qty -> \(intVal)")
            }
        }
        
        newItemSelected.totalPrice = String(Int(str!)! * Int(qty!)!)
        print("TOTALPRICE \(newItemSelected.totalPrice)")
        
        try! uiRealm.write() {
            uiRealm.add(newItemSelected)
        }
        
    }
    
    
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -200
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func requestShareURL() {
        let str = item?.price as NSString!
        
        
//        let strArr = str!.characters.split{$0 == " "}.map(String.init)
        var shareURLRequest = "";
//        for item in strArr {
//            let components = item.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
//            
//            let part = components.joinWithSeparator("")
//            
//            if let intVal = Int(part) {
//                str = String(intVal)
//                print("this is a number -> \(intVal)")
//                shareURLRequest = "http://gocerebro.com/ahkl/mobytill/GenPaymentLink.php?MODE&MERCHANTID=MOLWallet_Dev1&AMOUNT=\(str)&ORDERID=123456&BILL_NAME=Ainoor&BILL_EMAIL=Ainoor@test.com&BILL_MOBILE=01345675&DESC=SAMPLE&COUNTRY=my&VKEY=c6c5cdaabf772a366e1b5ba8a512afac"
//            }
//        }
        shareURLRequest = "http://gocerebro.com/ahkl/mobytill/GenPaymentLink.php?MODE&MERCHANTID=MOLWallet_Dev1&AMOUNT=\(str)&ORDERID=123456&BILL_NAME=Ainoor&BILL_EMAIL=Ainoor@test.com&BILL_MOBILE=01345675&DESC=SAMPLE&COUNTRY=my&VKEY=c6c5cdaabf772a366e1b5ba8a512afac"
        Alamofire.request(.GET, shareURLRequest, parameters: nil)
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
    }
    
    @IBAction func shareLinkSheet(sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [self.shareURL as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
