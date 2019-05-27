//
//  LoginViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 26/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailtTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
//        if !self.emailtTextField.hasText {
//            print("Handling email failure")
//            return
//            
//        }
//        if !self.passwordTextField.hasText {
//            print("Handling pwd failure")
//            return
//            
//        }
//        
        
        var email = self.emailtTextField.text!
        var password = self.passwordTextField.text!
        
        
        email = "pastr68@gmail.com"
        password = "asdfghjkl"
        
        Auth.auth().signIn(withEmail: email, password: password) { (r, error) in
            
            if error != nil {
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                        
                    case .invalidEmail:
                        print("invalid email")
                    case .userNotFound:
                        print("Nao achei esse viado")
                    case .wrongPassword:
                        print("Deu ruim na senha")
                    default:
                        print("Other error!")
                    }
                }
                
            } else {
                print("Login deu boa1")
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            }
            
        }
        
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
