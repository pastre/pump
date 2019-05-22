//
//  SignalViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignalViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("/signals")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSend(_ sender: Any) {
        guard let message = self.messageTextField.text else { return }
        let timestamp = Date().timeIntervalSince1970
        let data : [String: Any] = ["message" : message, "timestamp" : timestamp]
        ref.childByAutoId().setValue(data)
        print("foi no bttt")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
