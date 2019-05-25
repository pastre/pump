//
//  DayTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import Foundation
import UIKit

class DayTableViewCell: ProfitTableViewCell{
    
    @IBOutlet weak var firstAction: UILabel!
    @IBOutlet weak var secondAction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCalls(){
        // TODO: Reimplementar
//        let log = self.log as! Day
//        let a1 = log.actions[0], a2 = log.actions[1]
//
//        if a1 == "compre"{
//            self.firstAction.textColor = Constants.PLUS_GREEN
//        }else{
//            self.firstAction.textColor = Constants.NEGATIVE_RED
//        }
//
//        if a2 == "compra"{
//            self.secondAction.textColor = Constants.PLUS_GREEN
//        }else{
//            self.secondAction.textColor = Constants.NEGATIVE_RED
//        }
//
//        self.firstAction.text = a1
//        self.secondAction.text = a2
//
    }
}
