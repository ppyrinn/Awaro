//
//  Member.swift
//  Awaro
//
//  Created by Poppy on 20/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit
import CloudKit

class Member : NSObject {
    var id: CKRecord.ID!
    var fullName: String!
    var email : String!
    var userID : Int!
    var database: CKDatabase!
    var sessionID : Int!
    var currentDuration : Int!
    var achievedTitle : String!
    var activateChallenge : Bool!
    var badgePicture : String!
    var badgeTitle : String!
    var didChallengeCounter : Int!
    var historyID : Int!
    var joinAt : Int!
    var xp : Int!
    var question : String!
    var answerA : String!
    var answerB : String!
    var answerC : String!
    var answerD : String!
}
