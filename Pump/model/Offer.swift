//
//  Offer.swift
//  Pump
//
//  Created by Bruno Pastre on 28/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation

class Offer {
    init(name: String?, value: Float?) {
        self.name = name
        self.value = value
    }
    
    init(fromDict dict: NSDictionary) {
        self.name = (dict["name"]! as! String)
        self.value = (dict["value"]! as! Float)
    }
    
    var name: String!
    var value: Float!
    
}
