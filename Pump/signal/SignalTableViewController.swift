//
//  SignalTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignalTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var signals: [Signal]! = {
        var signals: [Signal]! = [Signal]()
        
        return signals
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("signals")
        
        
        ref.observe(.childAdded, with: { (snap) in
            self.onAdded(snap: snap)
            })
        self.checkAdmin()
    }
    
    func checkAdmin(){
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference().child("users/\(uid)")
        ref.observeSingleEvent(of: .value, with: {
            (snap) in
            print("Vale", snap.value)
            let user = snap.value as! NSDictionary
            if user["isAdmin"] as! Bool  {
                self.enableAdmin()
            }
            
        })
    }
    
    func enableAdmin(){
        let btt = UIBarButtonItem(title: "Admin", style: .plain, target: self, action: #selector(self.presentAdmin))
        //        btt.title = "asd"
        self.navigationItem.rightBarButtonItem = btt
    }
    
    
    @objc func presentAdmin(){
        self.performSegue(withIdentifier: "adminSignal", sender: "admin")
    }
    
    
    func onAdded(snap: DataSnapshot){
        
        let dict = snap.value! as! NSDictionary
        let b64Message = dict["message"] as! String
        let date = Date.init(timeIntervalSince1970: TimeInterval(exactly: dict["timestamp"] as! Double)!)
        let message =  b64Message.fromBase64()!
        print("Message is", message)
        let toAppend = Signal(message: message, timestamp: date)
        
        self.signals.append(toAppend)
        self.tableView.reloadData()
        self.scrollToBottom(animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.signals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signalCell", for: indexPath) as! SignalTableViewCell
        let ordered = signals.sorted { (s1, s2) -> Bool in
            return s1.timestamp < s2.timestamp
        }
        let signal = ordered[indexPath.item]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        formatter.setLocalizedDateFormatFromTemplate("dd/MM")
        let date = formatter.string(from: signal.timestamp)
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let hour = formatter.string(from: signal.timestamp)
        cell.mensagem.text = signal.message
        cell.dateLabel.text = date
        cell.hourLabel.text = hour
        

        return cell
    }
    
    func scrollToBottom(animated: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.signals.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }

}
