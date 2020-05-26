//
//  ChallengeAnswerContainerVC.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 22/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class ChallengeAnswerContainerVC: UIViewController {
    
    //MARK: - Variables
    var challengeAnswerTableVCReference: ChallengeAnswerTableVC?
    var sessionID = Int()
    var timer = Timer()
    var duration = challengeDuration
    var answerDuration = 0
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\n\n is challenge exist = \(challengeExist)\n\n")
        
        User.getAllSessionMembers(sessionID: sessionID)
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: "", xp:currentXP ?? 0, answerDuration: 0)
        
        toggleTimer(on: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isModalInPresentation = true
        navigationController?.navigationBar.isHidden = true
        
        roundedView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    // MARK: - IBAction
    @IBAction func submitButtonAction(_ sender: Any) {
        //bikin fungsi utk compare if selectedAnswer == answerA, brarti currentScore++ (dia ini global variable)
        //let answerA = self.challengeAnswerTableVCReference?.answerA
        let selectedAnswer = self.challengeAnswerTableVCReference?.selectedAnswer
        
        if selectedAnswer == challengeAnswerA {
            currentScore += 1
            currentXP! += 4
        }
        else {
            print("Wrong Answer!")
        }
        
        User.getAllSessionMembers(sessionID: sessionID)
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: selectedAnswer ?? "", xp: currentXP ?? 0, answerDuration: answerDuration)
        print("YourScore: \(currentScore)")
        
        challengeExist = false
        print("\n\n is challenge exist = \(challengeExist)\n\n")
        
        Session.setChallengeToDone(sessionID: sessionID)
        print("\n\nchallenge to done in session \(sessionID)\n\n")
        
        if selectedAnswer == challengeAnswerA {
            performSegue(withIdentifier: "RightAnswerSegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "WrongAnswerSegue", sender: nil)
        }
    }
    
    
    // MARK: - Function
    func saveContrainerViewReference(vc: ChallengeAnswerTableVC){
        self.challengeAnswerTableVCReference = vc
    }
    
    func toggleTimer(on : Bool){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            guard let strongSelf = self else {return}
            
            strongSelf.duration -= 1
            strongSelf.answerDuration += 1
            
            if strongSelf.duration < 10 {
                strongSelf.durationLabel.text = "00:0\(strongSelf.duration)"
                
                if strongSelf.duration == 0 {
                    let selectedAnswer = self!.challengeAnswerTableVCReference?.selectedAnswer
                    
                    if selectedAnswer == challengeAnswerA {
                        currentScore += 1
                        currentXP! += 4
                    }
                    else {
                        print("Wrong Answer!")
                    }
                    print("YourScore: \(currentScore)")
                    
                    User.getAllSessionMembers(sessionID: strongSelf.sessionID)
                    User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: selectedAnswer ?? "", xp: currentXP ?? 0, answerDuration: strongSelf.answerDuration )
                    
                    challengeExist = false
                    print("\n\n is challenge exist = \(challengeExist)\n\n")
                    
                    Session.setChallengeToDone(sessionID: self!.sessionID)
                    print("\n\nchallenge to done in session \(self!.sessionID)\n\n")
                    
                    self!.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    func roundedView() {
        durationView.layer.cornerRadius = 20
        durationView.clipsToBounds = true
        durationView.layer.masksToBounds = true
        durationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ChallengeAnswerEmbedSegue" {
            if let destination = segue.destination as? ChallengeAnswerTableVC {
                destination.sessionID = self.sessionID
            }
        }
    }
}
