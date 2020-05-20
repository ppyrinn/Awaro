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
    var helper:CoreDataHelper!
    var sessionData = [Session]()
    var members = [User]()
    var memberName = [String]()
    var currentTotalMember = 0
    
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
        
        // get session data
        helper = CoreDataHelper(context: getViewContext())
        sessionData = helper.fetchSpecificID(idType: "sessionID",id: sessionID) as [Session]
        print(sessionData)
        for data in sessionData{
            sessionName = data.sessionName ?? ""
            duration = Int(data.currentDuration)
        }
        

        // Do any additional setup after loading the view.
        sessionMemberTable.dataSource = self
        sessionMemberTable.delegate = self
        
        sessionIDLabel.text = "ID: \(sessionID)"
        sessionNameLabel.text = "\(sessionName)'s Session"
        
        toggleTimer(on: true)
    }
    
    
    // MARK: - IBAction Function
    @IBAction func quitSessionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to quit this session?", message: "You will still be able to rejoin this session afterwards.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { action in
            User.addSessionToMember(0, currentUserID!)
            self.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Functions
    
    func toggleTimer(on : Bool){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            
            guard let strongSelf = self else {return}
            strongSelf.duration += 1
            strongSelf.hour = strongSelf.duration / 3600
            strongSelf.min = (strongSelf.duration % 3600)/60
            strongSelf.sec = strongSelf.duration % 60
            
            if(strongSelf.hour < 10){
                strongSelf.timerLabel.text = "0\(strongSelf.hour) : \(strongSelf.min) : \(strongSelf.sec)"
                if(strongSelf.min < 10){
                    strongSelf.timerLabel.text = "0\(strongSelf.hour) : 0\(strongSelf.min) : \(strongSelf.sec)"
                    if(strongSelf.duration < 10){
                        strongSelf.timerLabel.text = "0\(strongSelf.hour) : 0\(strongSelf.min) : 0\(strongSelf.sec)"
                    }
                }
            }
            
            strongSelf.members = strongSelf.helper.fetchSpecificID(idType: "sessionID", id: strongSelf.sessionID) as [User]
                if strongSelf.currentTotalMember != strongSelf.members.count{
                    strongSelf.currentTotalMember = strongSelf.members.count
                    strongSelf.memberName.removeAll()
                    for member in strongSelf.members{
                        strongSelf.memberName.append(member.fullName ?? "")
                    }
                }
                
                strongSelf.participantCountLabel.text = "Participants (\(strongSelf.currentTotalMember))"
            })
    }

}

extension SessionMemberVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionMemberCell", for: indexPath) as! SessionMemberCell

        // Configure the cell...

        return cell
    }
}
