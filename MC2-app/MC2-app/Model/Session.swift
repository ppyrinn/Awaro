//
//  Session.swift
//  Awaro
//
//  Created by Poppy on 21/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

var isSessionExist = true
var membersInSession = [String]()
var totalMembersInSession = 0

struct MembersDataInSession{
    var name:String
    var clockIn:String
    var score:Int
    var duration:Int
}

var membersData = [MembersDataInSession]()
