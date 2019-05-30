//
//  SignUpViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 26/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateField(f1: UITextField, f2: UITextField) -> String? {
        guard let email = f1.text else { return nil }
        guard let confirm = f2.text else { return nil }
        
        if email.isEmpty || confirm.isEmpty || email != confirm {
            return nil
        }
        
        return email
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let email = self.validateField(f1: self.emailTextField, f2: self.emailTextField) else { return }
        guard let password = self.validateField(f1: self.passwordTextField, f2: self.passwordTextField) else { return }
        guard let name = self.nameTextField.text else { return }
        guard let phone = self.phoneTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (r, e) in
            guard let result = r else{
                if let errCode = AuthErrorCode(rawValue: e!._code) {
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
                return
            }
            
            let changeReq = result.user.createProfileChangeRequest()
            
            changeReq.displayName = name
            
            changeReq.commitChanges(completion: { (e) in
                if let error = e{
                    print("Erro ao modificar o nome do viado", error.localizedDescription)
                }else{
                    let uid = result.user.uid
                    Database.database().reference().child("users/\(uid)").setValue(["phone": phone, "isAdmin": false, "signalDeadline": Date().timeIntervalSince1970])
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
