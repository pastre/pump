
//
//  AddWeekTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase


class AddWeekTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var monthTextView: UITextField!
    @IBOutlet weak var profitTextView: UITextField!
    
    var path: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.monthTextView.delegate = self
        self.profitTextView.delegate = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func onAdd(_ sender: Any) {
        guard let name = self.monthTextView.text else { return }
        let profit = self.profitTextView.hasText ? self.profitTextView.text : "..."
        
        
        let ref = Database.database().reference().child(self.path)
        
        print("Adding to", self.path)
        ref.childByAutoId().setValue([
            "name": name,
            "profit" : profit
            ])
        
    }

}
