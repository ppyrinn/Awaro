//
//  CloudKitHelper.swift
//  Awaro
//
//  Created by Poppy on 20/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitHelper {
    func createMember(id:Int,fullName:String,email:String) {
        let memberRecord = CKRecord(recordType: "Members")
        memberRecord["userID"] = id as CKRecordValue
        memberRecord["fullName"] = fullName as CKRecordValue
        memberRecord["email"] = email as CKRecordValue

        CKContainer.default().publicCloudDatabase.save(memberRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("\n\ncreate member is Error: \(error.localizedDescription)\n\n")
                } else {
                    print("\n\ncreate member is Done!\n\n")
                }
            }
        }
    }
}
