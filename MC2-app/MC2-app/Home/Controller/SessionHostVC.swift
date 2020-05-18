//
//  SessionHostVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 14/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class SessionHostVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var sessionHostTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sessionHostTable.dataSource = self
        sessionHostTable.delegate = self
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

extension SessionHostVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionHostCell", for: indexPath) as! SessionHostCell

        // Configure the cell...

        return cell
    }
}
