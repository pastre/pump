//
//  AddDAYTableViewCell.swift
//  Pump
//
//  Created by Bruno Pastre on 23/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddDayTableViewCell: FirebaseTableViewCell {

    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var profitTextField: UITextField!
    @IBOutlet weak var message1TextField: UITextField!
    @IBOutlet weak var message2TextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAdd(){
        self.doneButton.setImage(UIImage(named: "add"), for: .normal)
        self.doneButton.addTarget(self, action: #selector(self.onAdd(_:)), for: .touchDown)
    }
    
    
    func setEdit(){
        self.doneButton.setImage(UIImage(named: "check"), for: .normal)
        self.doneButton.addTarget(self, action: #selector(self.onEdit(_:)), for: .touchDown)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func onAdd(_ sender: Any) {
        
        let ref = Database.database().reference().child(path)
        guard let name = self.dayTextField.text else {  return }
        let profit = self.profitTextField.text ?? "..."
        
        let m1 = self.message1TextField.text ?? "..."
        let m2 = self.message2TextField.text ?? "..."
        
        ref.childByAutoId().setValue(["name":  name, "profit" : profit, "message1": m1, "message2": m2])
    }
    
    @objc func onEdit(_ sender: Any){
        
        let ref = Database.database().reference().child(path)
        guard let name = self.dayTextField.text else {  return }
        let profit = self.profitTextField.text ?? "..."
        
        let m1 = self.message1TextField.text ?? "..."
        let m2 = self.message2TextField.text ?? "..."
        
        ref.setValue(["name":  name, "profit" : profit, "message1": m1, "message2": m2])
        
    }
}
