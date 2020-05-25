//
//  HistoryExtension.swift
//  Awaro
//
//  Created by Poppy on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

extension History{
    static func createHistory(userID:Int, sessionID:Int, sessionName:String, sessionDate:String, sessionDuration:Int, userClockIn:String, memberDuration:Int, memberScore:Int){
        let memberRecord = CKRecord(recordType: "Histories")
        memberRecord["userID"] = userID as CKRecordValue
        memberRecord["sessionID"] = sessionID as CKRecordValue
        memberRecord["sessionName"] = sessionName as CKRecordValue
        memberRecord["sessionDate"] = sessionDate as CKRecordValue
        memberRecord["sessionDuration"] = sessionDuration as CKRecordValue
        memberRecord["userClockIn"] = userClockIn as CKRecordValue
        memberRecord["memberDuration"] = memberDuration as CKRecordValue
        memberRecord["memberScore"] = memberScore as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(memberRecord) { [self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("\n\ncreate history is Error: \(error.localizedDescription)\n\n")
                } else {
                    print("\n\ncreate history is Done!\n\n")
                }
            }
        }
    }
    
    static func getHistoryByUserID(userID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Histories", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                histories.removeAll()
                records.forEach{
                    print($0)
                    histories.append(historyData(userID: $0["userID"] as! Int, sessionID: $0["sessionID"] as! Int, sessionName: $0["sessionName"] as! String, sessionDate: $0["sessionDate"] as! String, sessionDuration: $0["sessionDuration"] as! Int, userClockIn: $0["userClockIn"] as! String, memberDuration: $0["memberDuration"] as! Int, memberScore: $0["memberScore"] as! Int))
                    print("\n\nget history is done\n\n")
                }
                print("\n\n")
            }
        }
    }
    
    static func getMemberToHistoryDetail(sessionID:Int,sessionDate:String){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "sessionID = %d AND sessionDate = %@", sessionID,sessionDate)
        let query = CKQuery(recordType: "Histories", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                memberInSessionHistory.removeAll()
                records.forEach{
                    print($0)
                    memberInSessionHistory.append($0["userID"] as! Int)
                    print("\n\nget member in session history is done\n\n")
                }
                print("\n\n")
            }
        }
    }
}
