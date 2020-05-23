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
    
    // MARK: - IBOutlet
    @IBOutlet weak var submitButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\n\nquestion = \(String(describing: challengeQuestion))\n\n")
    }
    
    
    // MARK: - IBAction
    @IBAction func submitButtonAction(_ sender: Any) {
        challengeExist = false
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore)
        
        //bikin fungsi utk compare if selectedAnswer == answerA, brarti currentScore++ (dia ini global variable)
        let answerA = self.challengeAnswerTableVCReference?.answerA
        let selectedAnswer = self.challengeAnswerTableVCReference?.selectedAnswer
        
        if selectedAnswer == "A" {
            currentScore+=1
        }
        else {
            print("Wrong Answer!")
        }
        print("YourScore: \(currentScore)")
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Function
    func saveContrainerViewReference(vc: ChallengeAnswerTableVC){
        self.challengeAnswerTableVCReference = vc
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
