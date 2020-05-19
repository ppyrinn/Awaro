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
    
    // MARK: - IBOutlet
    @IBOutlet weak var sessionMemberTable: UITableView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionIDLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helper = CoreDataHelper(context: getViewContext())
        sessionData = helper.fetchSpecificID(id: sessionID) as [Session]
        print(sessionData)
        for data in sessionData{
            sessionName = data.sessionName ?? ""
        }
        

        // Do any additional setup after loading the view.
        sessionMemberTable.dataSource = self
        sessionMemberTable.delegate = self
        
        sessionIDLabel.text = "ID : \(sessionID)"
        sessionNameLabel.text = "\(sessionName)'s Session"
    }
    
    
    // MARK: - IBAction Function
    @IBAction func quitSessionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to quit this session?", message: "You will still be able to rejoin this session afterwards.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { action in
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

}

extension SessionMemberVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionMemberCell", for: indexPath) as! SessionMemberCell

        // Configure the cell...

        return cell
    }
}
