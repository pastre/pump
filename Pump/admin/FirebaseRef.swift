//
//  FirebaseRef.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation


class BaseFirebaseRef{
    var name: String!
    var profit: String!
    var key: String!
    
    init(fromDict: Any, key: String) {
        print("Parsing",key, fromDict)
        let asDict = fromDict as! NSDictionary
        self.name = (asDict["name"] as! String)
        self.profit = (asDict["profit"] as! String)
        self.key = key
    }
    
    
}
//class ChildRef: BaseFirebaseRef{
//    var childRef: String?
//    
//    init(fromDict: Any, key: String,  childKey: String) {
//        super.init(fromDict: fromDict, key: key)
//        let asDict = fromDict as! NSDictionary
//        self.childRef = (asDict[childKey] as? String)
//    }
//    
//}


class DayRef: BaseFirebaseRef{
    
    var message1, message2: String!
    override init(fromDict: Any, key: String) {
        super.init(fromDict: fromDict, key: key)
        let asDict = fromDict as! NSDictionary
        self.message1 = (asDict["message1"] as? String)
        self.message2 = (asDict["message2"] as? String)
    }
    
}
