//
//  ChallengeResultVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 19/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ChallengeResultVC: UIViewController {
    
    //MARK: - Variables
    var question = challengeQuestion
    var answerA = challengeAnswerA
    var answerB = challengeAnswerB
    var answerC = challengeAnswerC
    var answerD = challengeAnswerD
    var duration = challengeDuration
    var minutes: Int = 0
    var seconds: Int = 0
    var participantsName = [String]()
    var participantsAnswer = [String]()
    var participantsDuration = [String]()
    var timer = Timer()
    var sessionID = Int()
    var memberWhoAnswer = [MembersDataInSession]()

    

    // MARK: - IBOutlet
    @IBOutlet weak var challengeQuestionLabel: UILabel!
    @IBOutlet weak var rightAnswerLabel: UILabel!
    @IBOutlet weak var challengeDurationLabel: UILabel!
    @IBOutlet weak var participantResultTable: UITableView!
    @IBOutlet weak var challengeResultTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadChallengeResult()
        toggleTimer(on: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //isModalInPresentation =  true
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        participantResultTable.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        configureNavigationBar(largeTitleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backgoundColor: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1), tintColor: #colorLiteral(red: 0.4093762636, green: 0.408560425, blue: 0.8285056949, alpha: 1), title: "Challenge Result", preferredLargeTitle: false)
        navigationItem.hidesBackButton = true
        //roundedNavigationBar(title: "History")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - IBAction Function
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Function
    func loadChallengeResult() {
        challengeQuestionLabel.text = question
        rightAnswerLabel.text = "Answer: \(answerA)"
        print(question)
        
        if duration < 60 {
            seconds = duration
            challengeDurationLabel.text = "Duration: \(seconds) sec"
        }
        if duration == 60 {
            minutes = duration / 60
            challengeDurationLabel.text = "Duration: \(minutes) min"
        }
        if duration > 60 {
            minutes = duration / 60
            seconds = duration % 60
            challengeDurationLabel.text = "Duration: \(minutes) min" + " " + "\(seconds) sec"
        }
    }
    
    func toggleTimer(on : Bool){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            guard let strongSelf = self else {return}
            
//            User.getAllSessionMembers(sessionID: strongSelf.sessionID)
            
            self?.memberWhoAnswer.removeAll()
            for member in membersData{
                if member.id != self?.sessionID{
                    self?.memberWhoAnswer.append(member)
                }
            }

            strongSelf.challengeResultTableView.reloadData()
        })
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
        return memberWhoAnswer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeResultCell", for: indexPath) as! ChallengeResultCell

        // Configure the cell...
            if memberWhoAnswer[indexPath.row].answerDuration < 60 {
                seconds = memberWhoAnswer[indexPath.row].answerDuration
                cell.answerDurationLabel.text = "in: \(seconds) sec"
            }
            if memberWhoAnswer[indexPath.row].answerDuration == 60 {
                minutes = memberWhoAnswer[indexPath.row].answerDuration / 60
                cell.answerDurationLabel.text = "in: \(minutes) min"
            }
            if memberWhoAnswer[indexPath.row].answerDuration > 60 {
                minutes = memberWhoAnswer[indexPath.row].answerDuration / 60
                seconds = memberWhoAnswer[indexPath.row].answerDuration % 60
                cell.answerDurationLabel.text = "in: \(minutes) min" + " " + "\(seconds) sec"
            }
            cell.participantNameLabel.text = memberWhoAnswer[indexPath.row].name
            print("\n\ndia jawab : \(memberWhoAnswer[indexPath.row].selectedAnswer)\n\n")
            if memberWhoAnswer[indexPath.row].selectedAnswer == challengeAnswerA {
                cell.participantAnswerLabel.text = "Answer: \(memberWhoAnswer[indexPath.row].selectedAnswer)"
                
                print(memberWhoAnswer[indexPath.row].selectedAnswer)
                
                cell.answerImageView.image = UIImage(named: "ansRight")
            }
            else if memberWhoAnswer[indexPath.row].selectedAnswer == "" {
                cell.participantAnswerLabel.text = "Answer: -"
                cell.answerImageView.image = UIImage(named: "ansWrong")
            }
            cell.badgeImage.image = UIImage(named: memberWhoAnswer[indexPath.row].badgePicture)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
}
