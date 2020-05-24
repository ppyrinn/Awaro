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
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var submitButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\n\n is challenge exist = \(challengeExist)\n\n")
        
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: "")
        
        toggleTimer(on: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Session.setChallengeToDone(sessionID: sessionID)
    }
    
    
    // MARK: - IBAction
    @IBAction func submitButtonAction(_ sender: Any) {
        //bikin fungsi utk compare if selectedAnswer == answerA, brarti currentScore++ (dia ini global variable)
        //let answerA = self.challengeAnswerTableVCReference?.answerA
        let selectedAnswer = self.challengeAnswerTableVCReference?.selectedAnswer
        
        if selectedAnswer == "A" {
            currentScore += 1
        }
        else {
            print("Wrong Answer!")
        }
        print("YourScore: \(currentScore)")
        
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: selectedAnswer ?? "")
        
        challengeExist = false
        print("\n\n is challenge exist = \(challengeExist)\n\n")
        
        Session.setChallengeToDone(sessionID: sessionID)
        print("\n\nchallenge to done in session \(sessionID)\n\n")
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Function
    func saveContrainerViewReference(vc: ChallengeAnswerTableVC){
        self.challengeAnswerTableVCReference = vc
    }
    
    func toggleTimer(on : Bool){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            guard let strongSelf = self else {return}
            
            strongSelf.duration -= 1
            
            if strongSelf.duration < 10 {
                strongSelf.navigationItem.title = "00:0\(strongSelf.duration)"
                
                if strongSelf.duration == 0 {
                    let selectedAnswer = self!.challengeAnswerTableVCReference?.selectedAnswer
                    
                    if selectedAnswer == "A" {
                        currentScore += 1
                    }
                    else {
                        print("Wrong Answer!")
                    }
                    print("YourScore: \(currentScore)")
                    
                    User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore, selectedAnswer: selectedAnswer ?? "")
                    
                    challengeExist = false
                    print("\n\n is challenge exist = \(challengeExist)\n\n")
                    
                    Session.setChallengeToDone(sessionID: self!.sessionID)
                    print("\n\nchallenge to done in session \(self!.sessionID)\n\n")
                    
                    self!.dismiss(animated: true, completion: nil)
                }
            }
        })
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
