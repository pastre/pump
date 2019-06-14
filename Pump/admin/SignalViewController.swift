//
//  SignalViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignalViewController: TextFieldViewController,  UITextViewDelegate {

    @IBOutlet weak var messageTextField: UITextView!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("/signals")
        self.messageTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSend(_ sender: Any) {
//        self.messageTextField.text = """
//        📣COMPRE IMEDIATAMENTE📣
//        Ativo: WDOM19
//        Preço: 4042.0
//        Número do sinal: 101
//        """
        guard let rawMessage = self.messageTextField.text else { return }
        let message = rawMessage.toBase64()
//        print("Message", message)
        let timestamp = Date().timeIntervalSince1970
        let data : [String: Any] = ["message" : message, "timestamp" : timestamp]
        ref.childByAutoId().setValue(data)
//        print("foi no bttt")
        
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
