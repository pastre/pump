//
//  Offer.swift
//  Pump
//
//  Created by Bruno Pastre on 28/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import StoreKit

class Offer {
    init(name: String?, value: NSDecimalNumber?, product: SKProduct) {
        self.name = name
        self.value = value
        self.product  = product
    }
    
    init(fromDict dict: NSDictionary) {
        self.name = (dict["name"]! as! String)
        self.value = (dict["value"]! as! NSDecimalNumber)
    }
    
    var name: String!
    var value: NSDecimalNumber!
    var product: SKProduct!
}
