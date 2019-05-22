//
//  SignalViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignalViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var messageTextField: UITextView!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("/signals")
        self.messageTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //Making A toolbar
        let keyboardDoneButtonShow = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: self.view.frame.size.height/17))
        //Setting the style for the toolbar
        keyboardDoneButtonShow.barStyle = UIBarStyle.blackTranslucent
        //Making the done button and calling the textFieldShouldReturn native method for hidding the keyboard.
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector("textFieldShouldReturn:"))
        //Calculating the flexible Space.
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //Setting the color of the button.
//        item.tintColor = UIColor .yellowColor()
        //Making an object using the button and space for the toolbar
        let toolbarButton = [flexSpace,doneButton]
        //Adding the object for toolbar to the toolbar itself
        keyboardDoneButtonShow.setItems(toolbarButton, animated: false)
        //Now adding the complete thing against the desired textfield
        messageTextField.inputAccessoryView = keyboardDoneButtonShow
        return true
        
    }
    
    //Function for hidding the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func onSend(_ sender: Any) {
        self.messageTextField.text = """
        📣COMPRE IMEDIATAMENTE📣
        Ativo: WDOM19
        Preço: 4042.0
        Número do sinal: 101
        """
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
