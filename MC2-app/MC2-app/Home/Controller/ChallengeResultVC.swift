//
//  ChallengeResultVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 19/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ChallengeResultVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var participantResultTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isModalInPresentation =  true
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        participantResultTable.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backgoundColor: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1), tintColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), title: "Challenge Result", preferredLargeTitle: false)
        navigationItem.hidesBackButton = true
        //roundedNavigationBar(title: "History")
    }
    
    
    // MARK: - IBAction Functin
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension ChallengeResultVC: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeResultCell", for: indexPath) as! ChallengeResultCell

        // Configure the cell...

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
}
