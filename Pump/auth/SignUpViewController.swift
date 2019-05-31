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
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
//    let toasterView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        return view
//    }()
    
    
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
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        guard let name = self.nameTextField.text else { return }
        guard let phone = self.phoneTextField.text else { return }
        
        self.loadingActivityIndicator.startAnimating()
        Auth.auth().createUser(withEmail: email, password: password) { (r, e) in
            
            guard let result = r else{
                if let errCode = AuthErrorCode(rawValue: e!._code) {
                    switch errCode {
                        case .invalidEmail:
                            print("invalid email")
                            self.performSegue(withIdentifier: "invalidForm", sender: "O email está errado")
                        case .userNotFound:
                            self.performSegue(withIdentifier: "invalidForm", sender: "Usuário não encontrado")
                        case .wrongPassword:
                            self.performSegue(withIdentifier: "invalidForm", sender: "Senha inválida")
                        case .weakPassword:
                            self.performSegue(withIdentifier: "invalidForm", sender: "Sua senha deve ter no mínimo 6 caracteres")
                        default:
                            print("Other error!", errCode, e.debugDescription)
                    }
                }
                
                self.loadingActivityIndicator.stopAnimating()
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
                    self.loadingActivityIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                    let loginViewController = self.navigationController?.viewControllers.forEach({ (vc) in
                        if vc is LoginViewController{
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
                }
            })
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "invalidForm"{
            print("Sender is ", sender ?? "SEM SENDER IRMAO")
            let dest = segue.destination as! WarningViewController
            let message = sender as? String
            dest.message = message
        }
    }
}

