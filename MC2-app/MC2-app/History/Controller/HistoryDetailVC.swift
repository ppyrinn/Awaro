//
//  HistoryDetailVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 14/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class HistoryDetailVC: UIViewController {
    
    // MARK: - Variables
    var sessionID: Int?
    var sessionName: String?
    var sessionDate: String?
    var sessionDuration: Int?
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viewContainingTableView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var historyDetailTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        historyDetailTable.dataSource = self
        historyDetailTable.delegate = self
        
        loadHistoryDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        roundedTopView()
        roundedTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        History.getMemberToHistoryDetail(sessionID: sessionID ?? 0, sessionDate: sessionDate ?? "")
        
        historyDetailTable.reloadData()
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
    
    func loadHistoryDetail() {
//        let hour = sessionDuration ?? 0 / 3600
//        let min = sessionDuration ?? 0 / 60
//        let sec = sessionDuration ?? 0 % 60
        
        print("Session Duration: \(sessionDuration ?? 0)")
//        print("Session Minute: \(min)")
//        print("Session Second: \(sec)")
        
//        if hour < 10 {
//            durationLabel.text = "0\(hour):\(min):\(sec)"
//            if min < 10 {
//                durationLabel.text = "0\(hour):0\(min):\(sec)"
//                if sec < 10 {
//                    durationLabel.text = "0\(hour):0\(min):0\(sec)"
//                }
//            }
//        }
        
        if sessionDuration ?? 0 < 60 {
            seconds = sessionDuration ?? 0
            durationLabel.text = "0\(hour):0\(minutes):\(seconds)"
        }
        if sessionDuration ?? 0 == 60 {
            minutes = sessionDuration ?? 0 / 60
            durationLabel.text = "0\(hour):0\(minutes):0\(seconds)"
        }
        if sessionDuration ?? 0 > 60 && sessionDuration ?? 0 < 3600 {
            minutes = sessionDuration ?? 0 / 60
            seconds = sessionDuration ?? 0 % 60
            print("\(minutes) min \(seconds) sec")
            durationLabel.text = "0\(hour):\(minutes):\(seconds)"
        }
        if sessionDuration ?? 0 == 3600 {
            hour = sessionDuration ?? 0 / 3600
            durationLabel.text = "0\(hour):0\(minutes):0\(seconds)"
        }
        if sessionDuration ?? 0 > 3600 {
            hour = sessionDuration ?? 0 / 3600
            minutes = sessionDuration ?? 0 / 60
            seconds = sessionDuration ?? 0 % 60
            durationLabel.text = "\(hour):\(minutes):\(seconds)"
        }
        
        self.title = "\(sessionName ?? "")'s Session"
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

extension HistoryDetailVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersInHistory.count
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
        
        cell.badgeImage.image = UIImage(named: membersInHistory[indexPath.row].badgePicture)
        cell.nameLabel.text = membersInHistory[indexPath.row].name

        return cell
    }
}
