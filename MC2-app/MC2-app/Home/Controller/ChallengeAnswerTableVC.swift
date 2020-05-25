//
//  ChallengeAnswerTableVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 21/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ChallengeAnswerTableVC: UITableViewController {
    
    //MARK: - Variables
    var sessionID = Int()
    var question = challengeQuestion
    var answerA = challengeAnswerA
    var answerB = challengeAnswerB
    var answerC = challengeAnswerC
    var answerD = challengeAnswerD
    var duration = challengeDuration
    var selectedAnswer = "" //disini nanti nampung answer yang dipilih user
    
    var answers = [challengeAnswerA, challengeAnswerB, challengeAnswerC, challengeAnswerD].shuffled()
    

    // MARK: - IBOutlet
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aAnswerLabel: UILabel!
    @IBOutlet weak var bAnswerLabel: UILabel!
    @IBOutlet weak var cAnswerLabel: UILabel!
    @IBOutlet weak var dAnswerLabel: UILabel!
    @IBOutlet weak var aAnswerButtonOutlet: UIButton!
    @IBOutlet weak var bAnswerButtonOutlet: UIButton!
    @IBOutlet weak var cAnswerButtonOutlet: UIButton!
    @IBOutlet weak var dAnswerButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadQuestionData()
        setButtonTag()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let challengeAnswerContainerVC = self.parent as! ChallengeAnswerContainerVC
        challengeAnswerContainerVC.saveContrainerViewReference(vc: self)
    }
    
    
    // MARK: - IBAction
    @IBAction func buttonPressed(_ sender: UIButton) {
        //clear all button selected state
        clearSelectedState()
        
        //select the button that was clicked
        sender.isSelected = true
        sender.borderWidth = 3
        sender.borderColor = #colorLiteral(red: 0.3333333333, green: 0.3098039216, blue: 0.7882352941, alpha: 1)
        
        //bikin fungsi utk nampung jawaban yg dipilih user ke variable selectedAnswer
        if sender.tag == 0 {
            selectedAnswer = answers[0]
            print(selectedAnswer)
        }
        if sender.tag == 1 {
            selectedAnswer = answers[1]
            print(selectedAnswer)
        }
        if sender.tag == 2 {
            selectedAnswer = answers[2]
            print(selectedAnswer)
        }
        if sender.tag == 3 {
            selectedAnswer = answers[3]
            print(selectedAnswer)
        }
    }
    
    
    //MARK: - Functions
    func loadQuestionData() {
        questionLabel.text = question
        aAnswerLabel.text = answers[0]
        bAnswerLabel.text = answers[1]
        cAnswerLabel.text = answers[2]
        dAnswerLabel.text = answers[3]
    }
    
    func setButtonTag() {
        aAnswerButtonOutlet.tag = 0
        bAnswerButtonOutlet.tag = 1
        cAnswerButtonOutlet.tag = 2
        dAnswerButtonOutlet.tag = 3
    }
    
    func clearSelectedState() {
        [aAnswerButtonOutlet, bAnswerButtonOutlet, cAnswerButtonOutlet, dAnswerButtonOutlet].forEach {
            $0!.isSelected = false
            $0!.borderColor = .clear
         }
    }
    
    //bikin fungsi utk random pelatakan jawabannya, lets say answerA letaknya di option C
    
    
    
    // MARK: - Table view data source

    // Uncomment to use Dynamic Prototypes
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if isDarkMode ==  true {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = .black
        }
        else {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = .black
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
