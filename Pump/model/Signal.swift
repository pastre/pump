////
////  Logs.swift
////  Pump
////
////  Created by Bruno Pastre on 21/05/19.
////  Copyright © 2019 Bruno Pastre. All rights reserved.
////

import Foundation

class Signal{
    internal init(message: String, timestamp: Date) {
        self.message = message
        self.timestamp = timestamp
    }
    
    var message: String!
    var timestamp: Date!
}

