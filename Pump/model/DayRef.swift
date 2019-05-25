//
//  DayRef.swift
//  Pump
//
//  Created by Bruno Pastre on 25/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation

class DayRef: BaseFirebaseRef{
    
    var message1, message2: String!
    override init(fromDict: Any, key: String) {
        super.init(fromDict: fromDict, key: key)
        let asDict = fromDict as! NSDictionary
        self.message1 = (asDict["message1"] as? String)
        self.message2 = (asDict["message2"] as? String)
    }
    
}


