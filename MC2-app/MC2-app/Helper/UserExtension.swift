//
//  UserExtension.swift
//  Awaro
//
//  Created by Poppy on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CloudKit

extension User{
    // fungsi tambah data ke core data
    static func createUser(_ id:Int, _ fullName:String, _ email:String){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        // entity body
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(id, forKey: "userID")
        insert.setValue(fullName, forKey: "fullName")
        insert.setValue(email, forKey: "email")
        
        do{
            // save data ke entity user core data
            try managedContext.save()
            print("\n\ncreate user data ke entity user core data berhasil\n\n")
            //                id += 1
        }catch let err{
            print(err)
        }
    }
    
    static func addSessionToMember(_ sessionID:Int,_ userID:Int){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userID = %d", userID)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(sessionID, forKey: "sessionID")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    static func deleteAll(context : NSManagedObjectContext){
        //karna dia minta bentuknya umum
        let request : NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        //try? itu sama kyk do catch, kalo dia error return nil
        try? context.execute(deleteRequest)
    }
    
    //MARK: - CloudKit Functions
    
    static func createMember(id:Int,fullName:String,email:String) {
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let memberRecord = CKRecord(recordType: "Members")
        memberRecord["userID"] = id as CKRecordValue
        memberRecord["fullName"] = fullName as CKRecordValue
        memberRecord["email"] = email as CKRecordValue
        memberRecord["sessionID"] = 0 as CKRecordValue
        memberRecord["memberDuration"] = 0 as CKRecordValue
        memberRecord["score"] = 0 as CKRecordValue
        memberRecord["selectedAnswer"] = "" as CKRecordValue
        memberRecord["badgeTitle"] = "Bronze I" as CKRecordValue
        memberRecord["badgePicture"] = "Bronze I" as CKRecordValue
        memberRecord["achievedTitle"] = "The noob one" as CKRecordValue
        memberRecord["xp"] = 100 as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(memberRecord) { [self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("\n\ncreate member is Error: \(error.localizedDescription)\n\n")
                } else {
                    print("\n\ncreate member is Done!\n\n")
                }
            }
        }
    }
    
    static func getMemberBySpecificEmail(email:String){
        // use default container, we can set custom container by setting
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "email = %@", email)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    userEmail = $0["email"]
                    userFullName = $0["fullName"]
                    currentUserID = $0["userID"]
                    currentXP = $0["xp"]
                    currentBadgeTitle = $0["badgeTitle"]
                    currentBadgePicture = $0["badgePicture"]
                    currentAchievedTitle = $0["achievedTitle"]
                    
                    print("\n\n\(currentXP)\n\n")
                }
                print("\n\n")
            }
            
        }
    }
    
    static func countAllMember() {
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fetch all record
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        // sort description
        let sort = NSSortDescriptor(key: "userID", ascending: false)
        query.sortDescriptors = [sort]
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            // deliver later when we reach CKAssets
            if let records = result {
                print("\n\nResult\n")
                records.forEach{
                    print($0)
                    memberCounter += 1
                    print(memberCounter)
                }
                print("\n\n")
            }
        }
    }
    
    static func assignSessionToMember(sessionID:Int, userID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["sessionID"] = sessionID as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nassign session to member is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nassign session to member is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
            
        }
    }
    
    static func getAllSessionMembers(sessionID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                totalMembersInSession = 0
                //                membersInSession.removeAll()
                membersData.removeAll()
                records.forEach{
                    print($0)
                    //                    membersInSession.append($0["fullName"] as! String)
                    membersData.append(MembersDataInSession(name: $0["fullName"] as! String, clockIn: $0["joinAt"] as! String, score: $0["score"] as! Int, duration: $0["memberDuration"] as! Int, selectedAnswer: $0["selectedAnswer"] as! String, badgeTitle: $0["badgeTitle"] as! String, badgePicture: $0["badgePicture"] as! String))
                    totalMembersInSession += 1
                    //                    print("\n\n\nMembers in session = \(membersInSession)\n\n\nTotal = \(totalMembersInSession)\n\n")
                }
                print("\n\n")
            }
            
        }
        
    }
    
    static func setMemberClockInTime(userID:Int, joinAt:String){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["joinAt"] = joinAt as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nassign clockin time to member is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nassign clockin time to member is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
    }
    
    //    static func setChallengeToUser(sessionID:Int, question:String, answerA:String, answerB:String, answerC:String, answerD:String, duration:Int){
    //        let container = CKContainer.default()
    //        let privateContainer = container.publicCloudDatabase
    //
    //        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
    //        let query = CKQuery(recordType: "Members", predicate: predicate)
    //
    //        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
    //            if let err = error {
    //                print(err.localizedDescription)
    //                return
    //            }
    //
    //            if let records = result {
    //                print("\n\n")
    //                records.forEach{
    //                    print($0)
    //                    $0["question"] = question as CKRecordValue
    //                    $0["answerA"] = answerA as CKRecordValue
    //                    $0["answerB"] = answerB as CKRecordValue
    //                    $0["answerC"] = answerC as CKRecordValue
    //                    $0["answerD"] = answerD as CKRecordValue
    //                    $0["challengeDuration"] = duration as CKRecordValue
    //                    $0["isChallengeAvailable"] = true as CKRecordValue
    //
    //                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
    //                        DispatchQueue.main.async {
    //                            if let error = error {
    //                                print("\n\nset challenge to user is Error: \(error.localizedDescription)\n\n")
    //                            } else {
    //                                print("\n\nset challenge to user is Done!\n\n")
    //                            }
    //                        }
    //                    }
    //                }
    //                print("\n\n")
    //            }
    //        }
    //    }
    
    //    static func getChallengeToUser(sessionID:Int){
    //        let container = CKContainer.default()
    //        let privateContainer = container.publicCloudDatabase
    //
    //        // fecth with array
    //        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
    //        let query = CKQuery(recordType: "Members", predicate: predicate)
    //
    //        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
    //            if let err = error {
    //                print(err.localizedDescription)
    //                return
    //            }
    //
    //            if let records = result {
    //                print("\n\n")
    //                records.forEach{
    //                    print($0)
    //                    currentChallenge?.question = $0["question"] as! String
    //                    currentChallenge?.a = $0["answerA"] as! String
    //                    currentChallenge?.b = $0["answerB"] as! String
    //                    currentChallenge?.c = $0["answerC"] as! String
    //                    currentChallenge?.d = $0["answerD"] as! String
    //                    currentChallenge?.duration = $0["duration"] as! Int
    //                    currentChallenge?.available = ($0["isChallengeAvailable"] != nil)
    //                }
    //                print("\n\n")
    //            }
    //
    //        }
    //    }
    
    static func setScoreToUser(userID:Int, score:Int, selectedAnswer:String, xp:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["score"] = score as CKRecordValue
                    $0["isChallengeAvailable"] = false as CKRecordValue
                    $0["selectedAnswer"] = selectedAnswer as CKRecordValue
                    $0["xp"] = xp as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset score to member is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset score to member is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
    }
    
    static func setMemberDuration(userID:Int, duration:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["memberDuration"] = duration as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset member duration is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset member duration is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
        
    }
    
    static func setBadgeToMember(userID:Int, badgeTitle:String, badgePicture:String, achievedTitle:String){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "userID = %d", userID)
        let query = CKQuery(recordType: "Members", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["badgeTitle"] = badgeTitle as CKRecordValue
                    $0["badgePicture"] = badgePicture as CKRecordValue
                    $0["achievedTitle"] = achievedTitle as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset badge to member is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset badge to member is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
        
    }
}
