//
//  SessionMemberVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 14/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class SessionMemberVC: UIViewController {
    
    // MARK: - Variables
    var sessionName = String()
    var sessionID = Int()
    var sessionDate = String()
    var helper:CoreDataHelper!
    var sessionData = [Session]()
    var members = [User]()
    var memberName = [String]()
    var memberClockIn = [String]()
    var currentTotalMember = 0
    var isSessionEnd:Bool?
    var memberDuration = 0
    
    var currentDateTime = Date()
    let formatter = DateFormatter()
    var time = ""
    
    var timer = Timer()
    var duration = 0
    var hour = 0
    var min = 0
    var sec = 0
    
    // MARK: - IBOutlet
    @IBOutlet weak var sessionMemberTable: UITableView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionIDLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var participantCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sessionMemberTable.dataSource = self
        sessionMemberTable.delegate = self
        
        sessionIDLabel.text = "ID: \(sessionID)"
        sessionNameLabel.text = "\(sessionName)'s Session"
        
        toggleTimer(on: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // get session data
        //        helper = CoreDataHelper(context: getViewContext())
        //        sessionData = helper.fetchSpecificID(idType: "sessionID",id: sessionID) as [Session]
        //        print(sessionData)
        //        for data in sessionData{
        //            sessionName = data.sessionName ?? ""
        //            duration = Int(data.currentDuration)
        //        }
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        time = formatter.string(from: currentDateTime)
        print("\n\n\(time)\n\n")
        User.setMemberClockInTime(userID: currentUserID ?? 0, joinAt: time)
    }
    
    
    // MARK: - IBAction Function
    @IBAction func quitSessionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to quit this session?", message: "You will still be able to rejoin this session afterwards.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { action in
            //            User.addSessionToMember(0, currentUserID!)
            History.createHistory(userID: currentUserID ?? 0, sessionID: self.sessionID, sessionName: self.sessionName, sessionDate: self.sessionDate, sessionDuration: self.duration, userClockIn: self.time)
            User.assignSessionToMember(sessionID: 0, userID: currentUserID!)
            isSessionExist = false
            User.setScoreToUser(userID: currentUserID ?? 0, score: 0, selectedAnswer: "", xp: currentXP ?? 0)
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func debugChallengeButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "ChallengeAnswerSegue", sender: nil)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ChallengeAnswerSegue" {
            //kirim data
            
            //tanya ke segue tujuannya kemana, di cek tujuannya bener ato engga itu view yang mau di tuju
            if let destination = segue.destination as? UINavigationController,
                let targetController = destination.topViewController as? ChallengeAnswerContainerVC{
                //                destination.sessionName = self.createdSessionName
                print("\n\nyang dikirim \(self.sessionID)\n\n")
                targetController.sessionID = self.sessionID
            }
        }
    }
    
    
    //MARK: - Functions
    
    func toggleTimer(on : Bool){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            
            guard let strongSelf = self else {return}
            strongSelf.duration += 1
            strongSelf.memberDuration += 1
            strongSelf.hour = strongSelf.duration / 3600
            strongSelf.min = (strongSelf.duration % 3600)/60
            strongSelf.sec = strongSelf.duration % 60
            
            if(strongSelf.hour < 10){
                strongSelf.timerLabel.text = "0\(strongSelf.hour):\(strongSelf.min):\(strongSelf.sec)"
                if(strongSelf.min < 10){
                    strongSelf.timerLabel.text = "0\(strongSelf.hour):0\(strongSelf.min):\(strongSelf.sec)"
                    if(strongSelf.duration < 10){
                        strongSelf.timerLabel.text = "0\(strongSelf.hour):0\(strongSelf.min):0\(strongSelf.sec)"
                    }
                }
            }
            
//            if strongSelf.isSessionEnd == false{
//                //                Session.setSessionDuration(strongSelf.sessionID, strongSelf.duration)
//                Session.setCurrentDuration(sessionID: strongSelf.sessionID, duration: strongSelf.duration)
//            }
            
            //            strongSelf.members = strongSelf.helper.fetchSpecificID(idType: "sessionID", id: strongSelf.sessionID) as [User]
            
            User.getAllSessionMembers(sessionID: strongSelf.sessionID)
            Session.getChallengeFromSession(sessionID: strongSelf.sessionID)

            User.setMemberDuration(userID: currentUserID ?? 0, duration: strongSelf.memberDuration)
            
            print("\n\ntotal current member \(String(describing: totalMembersInSession))\n\n\n")
            if strongSelf.currentTotalMember != totalMembersInSession{
                strongSelf.currentTotalMember = totalMembersInSession
                //                strongSelf.memberName.removeAll()
                //                self?.sessionHostTable.reloadData()
                //                for member in membersInSession{
                //                    strongSelf.memberName.append(member)
                //                    self?.sessionHostTable.reloadData()
                //                }
                strongSelf.memberName.removeAll()
                strongSelf.memberClockIn.removeAll()
                self?.sessionMemberTable.reloadData()
                for member in membersData{
                    strongSelf.memberName.append(member.name)
                    strongSelf.memberClockIn.append(member.clockIn)
                    self?.sessionMemberTable.reloadData()
                }
            }
            
            strongSelf.participantCountLabel.text = "Participants (\(strongSelf.currentTotalMember))"
            
            if challengeExist == true {
                self!.performSegue(withIdentifier: "ChallengeAnswerSegue", sender: nil)
            }
        })
    }
}

extension SessionMemberVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionMemberCell", for: indexPath) as! SessionMemberCell
        
        // Configure the cell...
        cell.badgeImageView.image = UIImage(named: membersData[indexPath.row].badgePicture)
        
        if membersData[indexPath.row].id == sessionID {
            cell.participantLabel.text = membersData[indexPath.row].name + " " + "(Host)"
        }
        else {
            cell.participantLabel.text = membersData[indexPath.row].name
        }
        
        cell.clockInLabel.text = membersData[indexPath.row].clockIn
        
        return cell
    }
}

