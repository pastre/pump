
//
//  SignalTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class SignalTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var mensagem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
