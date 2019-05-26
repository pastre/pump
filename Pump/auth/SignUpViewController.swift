//
//  SignUpViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 26/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        guard let name = self.nameTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (r, e) in
            guard let result = r else{
                print("Erro ao criar o usuario", e?.localizedDescription)
                return
            }
            
            let changeReq = result.user.createProfileChangeRequest()
            
            changeReq.displayName = name
            
            changeReq.commitChanges(completion: { (e) in
                if let error = e{
                    print("Erro ao modificar o nome do viado", error.localizedDescription)
                }else{
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
