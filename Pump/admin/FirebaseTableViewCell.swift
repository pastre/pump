//
//  FirebaseTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 24/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class FirebaseTableViewCell: UITableViewCell {

    var path: String!
    var data: ChildRef!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
