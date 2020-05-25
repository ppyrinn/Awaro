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
    static func createHistory(userID:Int, sessionID:Int, sessionName:String, date:String, duration:Int){
        let memberRecord = CKRecord(recordType: "Histories")
        memberRecord["userID"] = userID as CKRecordValue
        memberRecord["sessionID"] = sessionID as CKRecordValue
        memberRecord["sessionID"] = sessionID as CKRecordValue
        
        
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
}
