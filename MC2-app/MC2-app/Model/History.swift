//
//  History.swift
//  Awaro
//
//  Created by Poppy on 25/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation

struct historyData {
    var userID:Int
    var sessionID:Int
    var sessionName:String
    var sessionDate:String
    var sessionDuration:Int
    var userClockIn:String
}

var histories = [historyData]()
