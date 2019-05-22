//
//  ProfitTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class ProfitTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var profit: UILabel!
    
    var log: Log!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPositive(){
        self.profit.textColor = Constants.PLUS_GREEN
        self.profit.text = "+\(self.log.profit!)%"
    }
    
    func setNegative(){
        self.profit.textColor = Constants.NEGATIVE_RED
        self.profit.text = "\(self.log.profit!)%"
        
    }
    
    func setOpen(){
        
        self.profit.textColor = Constants.OPEN_GREY
        self.profit.text = "..."
    }
    
}
