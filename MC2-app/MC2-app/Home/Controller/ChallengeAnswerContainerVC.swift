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
    var sessionID = Int()
    
    // MARK: - IBOutlet
    @IBOutlet weak var submitButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\n\nquestion = \(String(describing: challengeQuestion))\n\n")
    }
    
    
    // MARK: - IBActions
    @IBAction func submitButtonAction(_ sender: Any) {
        challengeExist = false
        User.setScoreToUser(userID: currentUserID ?? 0, score: currentScore)
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
