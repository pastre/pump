//
//  Logs.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation


class Log {
    internal init(name: String?, proft: Float?) {
        self.name = name
        self.proft = proft
        self.createdAt = Date()
    }
    
    var createdAt: Date!
    var name: String!
    var proft: Float!
}

class Month: Log{
    internal init(name: String?, proft: Float?, weeks: [Week]?) {
        super.init(name: name, proft: proft)
        self.weeks = weeks
    }
    
    
    var weeks: [Week]!
    
}

class Week: Log{
    internal init(name: String?, proft: Float?, days: [Day]!) {
        super.init(name: name, proft: proft)
        self.days = days
    }
    
    var days: [Day]!
}

class Day: Log {
    
    internal init(name: String?, proft: Float?, actions: [String]?) {
        super.init(name: name, proft: proft)
        self.actions = actions
    }
    
    var actions: [String]!
    
    
}


class Signal{
    internal init(message: String, timestamp: Date) {
        self.message = message
        self.timestamp = timestamp
    }
    
    var message: String!
    var timestamp: Date!
}
