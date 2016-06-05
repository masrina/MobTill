//
//  ShoppingCart.swift
//  MobTill
//
//  Created by Masrina on 05/06/2016.
//  Copyright © 2016 iProperty. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingCart: Object {
    dynamic var name = ""
    let listOfitems = List<SelectedItems>()
    
    
}
