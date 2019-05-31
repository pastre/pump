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
        var email = self.emailtTextField.text!
        var password = self.passwordTextField.text!
        
//        email = "pastr68@gmail.com"
//        password = "asdfghjkl"
//                email = "brunopaster@gmail.com"
//                password = "Xmicromp45"
        
        Auth.auth().signIn(withEmail: email, password: password) { (r, error) in
            
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                        case .invalidEmail:
                            self.performSegue(withIdentifier: "failedSegue", sender: "Email inválido")
                        case .userNotFound:
                            self.performSegue(withIdentifier: "failedSegue", sender: "Este usuário não existe")
                        case .wrongPassword:
                            self.performSegue(withIdentifier: "failedSegue", sender: "Usuário ou senha incorreto")
                        default:
                            print("Other error!", errCode, error)
                    }
                }
            } else {
                print("Login deu boa1")
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            }
            
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "failedSegue"{
            let dest = segue.destination as! WarningViewController
            dest.message = sender as! String
        }
    }
 

}
