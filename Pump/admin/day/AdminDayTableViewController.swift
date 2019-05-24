//
//  AdminDayTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 23/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase


class AdminDayTableViewController: FirebaseTableViewController {

    var month: ChildRef!
    var week: ChildRef!
    
    override func viewDidLoad() {
        self.ref = Database.database().reference().child("/months/\(month.key!)/weeks/\(week.key!)/days")
        super.viewDidLoad()
    }
    
    override func generateData(with snap: DataSnapshot) -> BaseFirebaseRef {
        print("Generated based on", snap)
        let month = DayRef(fromDict: snap.value!, key: snap.key)
        
        return month
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.dataToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addDay", for: indexPath) as! AddDAYTableViewCell
            
            cell.path = "/months/\(month.key!)/weeks/\(week.key!)/days"
            cell.setAdd()
            //            cell.path = "/weeks/\(self.month)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addDay", for: indexPath) as! AddDAYTableViewCell
        let data = self.dataToDisplay[indexPath.item - 1] as! DayRef
        
        cell.dayTextField.text = data.name
        cell.profitTextField.text = data.profit
        cell.message1TextField.text = data.message1
        cell.message2TextField.text = data.message2
        
        cell.path  = "/months/\(month.key!)/weeks/\(week.key!)/days/\(data.key!)"
        cell.setEdit()
        
        return cell
    }
    
    

}
