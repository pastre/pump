//
//  SignalTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase


class SignalTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var signals: [Signal]! = {
        var signals: [Signal]! = [Signal]()
        

        
//        for i in 0...10{
//            let mess = i % 2 == 0 ? """
//            📣COMPRE IMEDIATAMENTE📣
//            Ativo: WDOM19
//            Preço: 4042.0
//            Número do sinal: 101
//            """ : """
//            📣FECHE A OPERAÇÃO IMEDIATAMENTE📣
//            Ativo: WDOM19
//            Preço: 4067
//            Número do sinal: 101
//            """
//            let toAppend = Signal(message: "\(mess)", timestamp: Date())
//            signals.append(toAppend)
//        }
        
        return signals
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("signals")
        
        
        ref.observe(.childAdded, with: { (snap) in
            self.onAdded(snap: snap)
            })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func onAdded(snap: DataSnapshot){
//        print(type(of: snap.value), snap.value!)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        // Configure the cell...

        return cell
    }
    
    func scrollToBottom(animated: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.signals.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
