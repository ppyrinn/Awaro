//
//  SessionResultVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 16/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class SessionResultVC: UIViewController {
    
    // MARK: - Variables
    var sessionName = String()
    var sessionID = Int()
    var memberName = [String]()
    var currentTotalMember = 0
    var memberClockIn = [String]()
    var sessionDuration = Int()
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viewContainingTableView: UIView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionIDLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var participantCountLabel: UILabel!
    @IBOutlet weak var sessionResultTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sessionResultTable.dataSource = self
        sessionResultTable.delegate = self
        
        sessionIDLabel.text = "ID: \(sessionID)"
        print(sessionID)
        sessionNameLabel.text = "\(sessionName)'s Session"
        
        let hour = sessionDuration / 3600
        let min = (sessionDuration % 3600)/60
        let sec = sessionDuration % 60
        
        if(hour < 10){
            durationLabel.text = "0\(hour):\(min):\(sec)"
            if(min < 10){
                durationLabel.text = "0\(hour):0\(min):\(sec)"
                if(sessionDuration < 10){
                    durationLabel.text = "0\(hour):0\(min):0\(sec)"
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        roundedTopView()
        roundedTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadSessionData()
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
        
        sessionResultTable.backgroundColor = .white
        sessionResultTable.cornerRadius = 10
        sessionResultTable.layer.masksToBounds = true
        sessionResultTable.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func loadSessionData() {
        let strongSelf = self
        
        User.getAllSessionMembers(sessionID: strongSelf.sessionID)

        print("\n\ntotal current member \(String(describing: totalMembersInSession))\n\n\n")
        if strongSelf.currentTotalMember != totalMembersInSession{
            strongSelf.currentTotalMember = totalMembersInSession
            strongSelf.memberName.removeAll()
            strongSelf.memberClockIn.removeAll()
            self.sessionResultTable.reloadData()
            for member in membersData{
                strongSelf.memberName.append(member.name)
                strongSelf.memberClockIn.append(member.clockIn)
                self.sessionResultTable.reloadData()
            }
        }
        
        strongSelf.participantCountLabel.text = "Participants (\(strongSelf.currentTotalMember))"
    }
    
    
    // MARK: - IBAction Function
    @IBAction func backToHomeButton(_ sender: Any) {
        view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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

extension SessionResultVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionResultCell", for: indexPath) as! SessionResultCell

        // Configure the cell...
        if isDarkMode == true {
            cell.contentView.backgroundColor = .white
            cell.placeholderView.backgroundColor = .white
        }
        else {
            cell.contentView.backgroundColor = .white
            cell.placeholderView.backgroundColor = .white
        }
        
        if sessionID == sessionID {
            cell.nameLabel.text = memberName[indexPath.row] + " " + "(Host)"
        }
        else {
            cell.nameLabel.text = memberName[indexPath.row]
        }
        cell.clockInLabel.text = memberClockIn[indexPath.row]
        
        return cell
    }
}
