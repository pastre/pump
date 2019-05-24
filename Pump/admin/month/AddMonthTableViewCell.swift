//
//  AddMonthTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddMonthTableViewCell: FirebaseTableViewCell, UITextFieldDelegate {

    @IBOutlet weak var monthTextView: UITextField!
    @IBOutlet weak var profitTextView: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    
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
    func setAdd(){
        self.doneButton.setImage(UIImage(named: "add"), for: .normal)
        self.doneButton.addTarget(self, action: #selector(self.onAdd(_:)), for: .touchDown)
    }
    
    
    func setEdit(){
        self.doneButton.setImage(UIImage(named: "check"), for: .normal)
        self.doneButton.addTarget(self, action: #selector(self.onEdit(_:)), for: .touchDown)
    }
    
    @objc func onAdd(_ sender: Any) {
        guard let name = self.monthTextView.text else { return }
        let profit = self.profitTextView.hasText ? self.profitTextView.text : "..."
        
        
        let ref = Database.database().reference().child(self.path)
        
        print("Adding to", self.path!)
        ref.childByAutoId().setValue([
            "name": name,
            "profit" : profit
            ])
        
    }
    
    @objc func onEdit(_ sender: Any){
        
        let ref = Database.database().reference().child(path)
        guard let name = self.monthTextView.text else {  return }
        let profit = self.profitTextView.text ?? "..."
        
        ref.setValue(["name":  name, "profit" : profit])
    }

    
    
}
