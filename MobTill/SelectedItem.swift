//
//  SelectedItem.swift
//  MobTill
//
//  Created by Masrina on 05/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit


class SelectedItem: NSObject {
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let priceKey = "price"
        static let quantityKey = "quantity"
        static let totalPriceKey = "totalprice"
    }
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var price: String
    var quantity: String
    var totalPrice: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let archiveURL = DocumentsDirectory.URLByAppendingPathComponent("selecteditems")
    
    // MARK: Initialization. failable initializer
    init?(name: String, photo: UIImage?, price: String, quantity: String, totalPrice: String) {
        self.name = name
        self.photo = photo
        self.price = price
        self.quantity = quantity
        self.totalPrice = totalPrice
        
        super.init()
        
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey:  PropertyKey.photoKey)
        aCoder.encodeObject(price, forKey: PropertyKey.priceKey)
        aCoder.encodeObject(quantity, forKey: PropertyKey.quantityKey)
        aCoder.encodeObject(totalPrice, forKey: PropertyKey.totalPriceKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let price = aDecoder.decodeObjectForKey(PropertyKey.priceKey) as! String
        let quantity = aDecoder.decodeObjectForKey(PropertyKey.quantityKey) as! String
        let totalPrice = aDecoder.decodeObjectForKey(PropertyKey.totalPriceKey) as! String
        
        self.init(name: name, photo: photo, price: price, quantity: quantity, totalPrice: totalPrice)
    }

}
