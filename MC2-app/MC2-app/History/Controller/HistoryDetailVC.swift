//
//  HistoryDetailVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 14/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class HistoryDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viewContainingTableView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var historyDetailTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backgoundColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), tintColor: .white, title: "History", preferredLargeTitle: true)
        //roundedNavigationBar(title: "History")
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        roundedTopView()
        roundedTableView()
    }
    
    
    // MARK: - Function
    func roundedTopView() {
        topView.backgroundColor = .white
        //topView.cornerRadius = 20
        //topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        topView.shadowColor = .black
        topView.shadowOffset = CGSize(width: 0, height: 0)
        topView.shadowOpacity = 0.2
        topView.shadowRadius = 4
    }
    
    func roundedTableView() {
        viewContainingTableView.backgroundColor = .clear
        viewContainingTableView.cornerRadius = 10
        viewContainingTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        viewContainingTableView.shadowColor = .black
        viewContainingTableView.shadowOffset = CGSize(width: 0, height: 0)
        viewContainingTableView.shadowOpacity = 0.1
        viewContainingTableView.shadowRadius = 2
        
        historyDetailTable.backgroundColor = .white
        historyDetailTable.cornerRadius = 10
        historyDetailTable.layer.masksToBounds = true
        historyDetailTable.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryDetailCell", for: indexPath) as! HistoryDetailCell

        // Configure the cell...
        if isDarkMode == true {
            cell.contentView.backgroundColor = .white
            cell.placeholderView.backgroundColor = .white
        }
        else {
            cell.contentView.backgroundColor = .white
            cell.placeholderView.backgroundColor = .white
        }

        return cell
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
