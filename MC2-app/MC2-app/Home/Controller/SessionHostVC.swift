//
//  SessionHostVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 14/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import CoreData

class SessionHostVC: UIViewController {
    
    // MARK: - Variables
    var sessionName = String()
    var sessionID = Int()
    var members = [User]()
    var helper: CoreDataHelper!
    var memberName = [String]()
    var currentTotalMember = 0
    
    var timer = Timer()
    var duration = 0
    var hour = 0
    var min = 0
    var sec = 0

    // MARK: - IBOutlet
    @IBOutlet weak var sessionHostTable: UITableView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionIDLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var participantCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        helper = CoreDataHelper(context: getViewContext())
        // Do any additional setup after loading the view.
        sessionHostTable.dataSource = self
        sessionHostTable.delegate = self
        
        for member in members{
            sessionID = Int(member.userID)
        }
        
        sessionIDLabel.text = "ID: \(sessionID)"
        print(sessionID)
        sessionNameLabel.text = "\(KeychainItem.currentUserBirthName ?? "Your Name")'s Session"
        toggleTimer(on: true)
    }
    
    
    // MARK: - IBAction Function
    @IBAction func createAwarenessButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateAwarenessSegue", sender: nil)
    }
    
    @IBAction func endSessionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to end this session?", message: "All of the participants will be removed if you end this session.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "End", style: .destructive, handler: { action in
            self.performSegue(withIdentifier: "EndSessionSegue", sender: nil)
            Session.deleteSession(self.sessionID)
            self.members.removeAll()
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
            
            Session.setSessionDuration(strongSelf.sessionID, strongSelf.duration)
            
            strongSelf.members = strongSelf.helper.fetchSpecificID(idType: "sessionID", id: strongSelf.sessionID) as [User]
            if strongSelf.currentTotalMember != strongSelf.members.count{
                strongSelf.currentTotalMember = strongSelf.members.count
                strongSelf.memberName.removeAll()
                self?.sessionHostTable.reloadData()
                for member in strongSelf.members{
                    strongSelf.memberName.append(member.fullName ?? "")
                    self?.sessionHostTable.reloadData()
                }
            }
            
            strongSelf.participantCountLabel.text = "Participants (\(strongSelf.currentTotalMember))"
        })
    }
}


//MARK: - Extensions
extension SessionHostVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionHostCell", for: indexPath) as! SessionHostCell

        // Configure the cell...
        cell.participantLabel.text = memberName[indexPath.row]

        return cell
    }
}
