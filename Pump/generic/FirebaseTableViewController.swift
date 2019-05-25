//
//  FirebaseTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase


class FirebaseTableViewController: UITableViewController {

    let noSegue = "NO_SEGUE"
    
    var ref: DatabaseReference!
    var dataToDisplay: [BaseFirebaseRef]!
    var segueId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataToDisplay = [BaseFirebaseRef]()
        
        self.ref.observe(.childAdded) { (snap) in
            self.onAdded(snap)
        }
        
        self.ref.observe(.childChanged) { (snap) in
            self.onChanged(child: snap)
        }
        
        
        self.ref.observe(.childRemoved) { (snap) in
            self.onRemoved(child: snap)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        let month = BaseFirebaseRef(fromDict: snap.value!, key: snap.key)
        
        return month
    }

    // MARK: - Firebase triggers
    
    func onAdded(_ snap: DataSnapshot){
        let data = generateData(with: snap)
        
        self.dataToDisplay.append(data)
        self.tableView.reloadData()
    }
    
    func onChanged(child snap: DataSnapshot){
        for (i, child) in self.dataToDisplay.enumerated(){
            if child.key == snap.key{
                let updatedChild = self.generateData(with: snap)
                self.dataToDisplay[i] = updatedChild
                self.tableView.reloadData()
                return
            }
        }
    }
    
    func onRemoved(child snap: DataSnapshot){
        for (i, child) in self.dataToDisplay.enumerated(){
            if child.key == snap.key{
                self.dataToDisplay.remove(at: i)
                self.tableView.reloadData()
                return
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 || self.segueId == self.noSegue { return }
        self.performSegue(withIdentifier: self.segueId, sender: self.tableView.cellForRow(at: indexPath))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataToDisplay.count
    }

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, done) in
            let cell =  self.tableView.cellForRow(at: indexPath) as! FirebaseTableViewCell
            self.delete(at: cell.path)
            done(true)
        }
        let actions = indexPath.item == 0 ? [] : [action]
        let ret = UISwipeActionsConfiguration(actions: actions)
        
        return ret
    }
    
    func delete(at path: String){
        let ref = Database.database().reference().child(path)
        
        ref.setValue(nil)
        print("Deleting at", path)
    }


}
