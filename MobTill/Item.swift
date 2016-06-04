//
//  Item.swift
//  MobTill
//
//  Created by Masrina on 04/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit

class Item: NSObject {
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let priceKey = "price"
    }
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var price: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let archiveURL = DocumentsDirectory.URLByAppendingPathComponent("items")
    
    // MARK: Initialization. failable initializer
    init?(name: String, photo: UIImage?, price: String) {
        self.name = name
        self.photo = photo
        self.price = price
        
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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let price = aDecoder.decodeObjectForKey(PropertyKey.priceKey) as! String
        
        self.init(name: name, photo: photo, price: price)
    }

}
