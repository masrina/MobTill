//
//  QRCodeViewController.swift
//  MobTill
//
//  Created by Masrina on 04/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit
import Alamofire

class QRCodeViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://gocerebro.com/ahkl/mobytill/genvcode.php?MODE=QR&AMOUNT=20.15&MERCHANTID=12345&ORDERID=0987654", parameters: nil)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    
                    if let url = NSURL(string: "http://api.qrserver.com/v1/create-qr-code/?data=https://goo.gl/n0PbIX&size=400") {
                        if let data = NSData(contentsOfURL: url) {
                            self.qrCodeImageView.image = UIImage(data: data)
                        }        
                    }
                case .Failure(let error):
                    print("Error: \(error)")
                }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
