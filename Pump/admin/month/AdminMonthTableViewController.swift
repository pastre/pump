//
//  AdminMonthTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdminMonthTableViewController: FirebaseTableViewController {

    override func viewDidLoad() {
        self.segueId = "adminShowWeek"
        self.ref = Database.database().reference().child("/months")
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        let month = BaseFirebaseRef(fromDict: snap.value!, key: snap.key)
        
        return month
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.dataToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMonth", for: indexPath) as! AddMonthTableViewCell
        if indexPath.item == 0{
            cell.setAdd()
            cell.path = "/months"
            return cell
        }
        
        let data = self.dataToDisplay[indexPath.item - 1]
        
        cell.monthTextView.text = data.name
        cell.profitTextView.text = data.profit
        cell.data = (data as! BaseFirebaseRef)
        cell.path = "/months/\(data.key!)"
        cell.accessoryType = .disclosureIndicator
        cell.setEdit()
        
        return cell
    }
    

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let dest = segue.destination as! AdminWeekTableViewController
        let cell = sender as! AddMonthTableViewCell
        
        dest.month = cell.data
    }

}
