//
//  MonthTableViewController.swift
//  Pump
//
//  Created by Bruno Pastre on 21/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit
import FirebaseDatabase


class MonthTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var months: [Month]! = {
        var months: [Month]! = [Month]()
        let names = ["JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL"]
        
//        for (i, name) in names.enumerated(){
//            var weeks: [Week]! = [Week]()
//            var days: [Day]! = [Day]()
//            for day in 1...31{
//                if day == 11 || day == 21 || day == 31{
//                    var newWeek: Week! = Week(name: "\(day - 10) - \(day)", proft: 12.0, days: days)
//                    weeks.append(newWeek)
//                    days = [Day]()
//                }
//                let newDay = Day(name: "\(day)", proft: 2.0, actions: ["compra", "venda"])
//                days.append(newDay)
//                print("Dia", day)
//            }
//
//            let newMonth = Month(name: name, proft: i % 2 == 0 ? 13.0 : -12.0, weeks: weeks)
//            months.append(newMonth)
//        }
        
        return months
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference().child("months")
        
        
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
        let monthDict = snap.value! as! NSDictionary
        let weeksList = monthDict["weeks"] as!  NSArray
        var weeks: [Week] = [Week]()
        for week in weeksList{
            let weekDict = week as! NSDictionary
            let daysList = weekDict["days"] as! NSArray
            var days: [Day] = [Day]()
            for day in daysList{
                let dayDict = day as! NSDictionary
                print("Daydict is", dayDict)
                let newDay = Day(name: "\(dayDict["name"]!)", hasProfit: (dayDict["hasProfit"] as! Bool), profit: (dayDict["profit"] as! Float), actions: (dayDict["messages"] as! [String]))
                days.append(newDay)
            }
            let newWeek = Week(name: (weekDict["name"] as! String),hasProfit: (weekDict["hasProfit"] as! Bool), profit: (weekDict["profit"] as! Float), days: days)
            weeks.append(newWeek)
        }
        let month: Month =  Month(name: (monthDict["name"] as! String),hasProfit: (monthDict["hasProfit"] as! Bool), profit: (monthDict["profit"] as! Float), weeks: weeks)
        self.months.append(month)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.months.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthCell", for: indexPath) as! ProfitTableViewCell

        let month = self.months[indexPath.item]
        cell.title.text = month.name
        cell.log = month
        if !month.hasProfit{
            // todo
        }else{
            if month.profit! >= 0{
                cell.setPositive()
            }else{
                cell.setNegative()
            }
            
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = (sender as! ProfitTableViewCell)
        let dest = segue.destination as! WeekTableViewController
        let month = cell.log as! Month
        dest.title = Constants.MONTH_ACR[month.name]
        dest.weeks = month.weeks
        
    }
 

}
