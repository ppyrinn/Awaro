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
}

var membersData = [MembersDataInSession]()

struct CurrentSessionData{
    var name:String
    var id:Int
    var duration:Int
}

var sessionData = [CurrentSessionData]()

struct sessionChallenge {
    var question = ""
    var a = ""
    var b = ""
    var c = ""
    var d = ""
    var duration = 0
    var available = false
}

var currentChallenge : sessionChallenge?
var currentScore = 0
