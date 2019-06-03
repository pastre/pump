//
//  TextFieldViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 31/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

//
//  BaseEditableViewController.swift
//  Activity Manager
//
//  Created by Bruno Pastre on 16/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    
    var content: UIView!
    var controller: UITableViewController!
    var hidingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Keyboard listeners
    
    func moveKeyboardUp(){
        self.content.transform = self.content.transform.translatedBy(x: 0, y: -self.view.frame.width / 2)
        UIView.animate(withDuration: 0.2) {
            self.hidingView?.alpha = 0
        }
    }
    
    func moveKeyboardDown(){
        self.content.transform = .identity
        
        UIView.animate(withDuration: 0.2) {
            self.hidingView?.alpha = 1
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - TextField delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.moveKeyboardUp()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Comecou a editar")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.moveKeyboardDown()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveKeyboardDown()
    }
    
    // MARK: - Button callbacks
}
