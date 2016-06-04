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
    }
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let archiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Initialization. failable initializer
    init?(name: String, photo: UIImage?) {
        self.name = name
        self.photo = photo
        
        super.init()
        // Initialization should fail if the name is empty or rating is negative
        if name.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey:  PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        self.init(name: name, photo: photo)
    }

}
