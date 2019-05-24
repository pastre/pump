//
//  AdminWeekTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 22/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase
class AdminWeekTableViewController: FirebaseTableViewController {

    var month: ChildRef!
    
    override func viewDidLoad() {
        self.ref = Database.database().reference().child("/months/\(month.key!)/weeks")
        super.viewDidLoad()
//        self.addCellId = "addMonth"
//        self.dataCellId = "adminMonthCell"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        print("Generated based on", snap)
        let month = ChildRef(fromDict: snap.value!, key: snap.key, childKey: "daysRef")
        
        return month
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 { return }
        self.performSegue(withIdentifier: "showDay", sender: self.tableView.cellForRow(at: indexPath))
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.dataToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addWeek", for: indexPath) as! AddWeekTableViewCell
            cell.path = "months/\(self.month.key!)/weeks"
            cell.setAdd()
//            cell.path = "/weeks/\(self.month)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addWeek", for: indexPath) as! AddWeekTableViewCell
        let data = self.dataToDisplay[indexPath.item - 1]
        
        cell.accessoryType = .disclosureIndicator
        cell.monthTextView.text = data.name
        cell.profitTextView.text = data.profit
        
        cell.path = "months/\(self.month.key!)/weeks/\(data.key!)"
        cell.data = (data as! ChildRef)
        cell.setEdit()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let dest = segue.destination as! AdminDayTableViewController
        let cell = sender as! AddWeekTableViewCell
        
        dest.month = self.month
        dest.week = cell.data
    }
    
}
