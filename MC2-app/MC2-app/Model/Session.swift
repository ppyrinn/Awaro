//
//  Session.swift
//  Awaro
//
//  Created by Poppy on 21/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

var isSessionExist = false
var membersInSession = [String]()
var totalMembersInSession = 0

struct MembersDataInSession{
    var name:String
    var clockIn:String
    var score:Int
    var duration:Int
    var selectedAnswer:String
    var badgeTitle:String
    var badgePicture:String
}

var membersData = [MembersDataInSession]()

struct CurrentSessionData{
    var name:String
    var id:Int
    var duration:Int
}

var sessionData = [CurrentSessionData]()

var currentScore = 0

var challengeQuestion = ""
var challengeAnswerA = ""
var challengeAnswerB = ""
var challengeAnswerC = ""
var challengeAnswerD = ""
var challengeDuration = 0
var challengeExist = false
