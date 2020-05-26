//
//  HistoryTableVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 11/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import CloudKit

class HistoryTableVC: UITableViewController, RoundedCornerNavigationBar {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backgoundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), tintColor: .white, title: "History", preferredLargeTitle: true)
        //roundedNavigationBar(title: "History")
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        History.getHistoryByUserID(userID: currentUserID ?? 0)
        print(histories.count)
        
        tableView.reloadData()
    }
    
    
    // MARK: - Function
    func refreshControl() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: "Reload History", attributes: attributes)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.refreshControl!.tintColor = UIColor.white
        self.refreshControl!.attributedTitle = attributedTitle
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        History.getHistoryByUserID(userID: currentUserID ?? 0)
        print(histories.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return histories.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if isDarkMode ==  true {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.black
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
        }
        else {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        }
    }

//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell

        // Configure the cell...
        if isDarkMode == true {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            cell.historyView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            cell.historyView.shadowColor = .black
            cell.historyView.shadowOffset = CGSize(width: 0, height: 0)
            cell.historyView.shadowRadius = 4
            cell.historyView.shadowOpacity = 0.2
        }
        else {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            cell.historyView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            cell.historyView.shadowColor = .black
            cell.historyView.shadowOffset = CGSize(width: 0, height: 0)
            cell.historyView.shadowRadius = 4
            cell.historyView.shadowOpacity = 0.2
        }
        cell.historyView.cornerRadius = 10
        
        cell.sessionName.text = "\(histories[indexPath.row].sessionName)'s Session"
        cell.sessionTime.text = histories[indexPath.row].sessionDate

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
