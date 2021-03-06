//
//  ColorPalete.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    static let PLUS_GREEN: UIColor = #colorLiteral(red: 0, green: 0.6969159245, blue: 0.1019514129, alpha: 1)
    static let NEGATIVE_RED: UIColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
    static let OPEN_GREY: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let MONTH_ACR : [String : String] = [
        "JAN": "Janeiro",
        "FEV": "Fevereiro",
        "MAR": "Março",
        "ABR": "Abril",
        "MAI": "Maio",
        "JUN": "Junho",
//        "JUL": "Julho"
    ]
}


extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
