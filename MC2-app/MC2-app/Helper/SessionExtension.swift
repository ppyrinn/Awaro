//
//  SessionExtension.swift
//  Awaro
//
//  Created by Poppy on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CloudKit

extension Session{
    static func createSession(_ sessionID:Int, _ sessionName:String) {
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        let userEntity = NSEntityDescription.entity(forEntityName: "Session", in: managedContext)
        
        // entity body
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        insert.setValue(sessionID, forKey: "sessionID")
        insert.setValue(sessionName, forKey: "sessionName")
        
        do{
            // save data ke entity user core data
            try managedContext.save()
            print("\n\ncreate session ke entity session core data berhasil\n\n")
            //                id += 1
        }catch let err{
            print(err)
        }
    }
    
    static func addMemberToSession(_ sessionID:Int,_ memberName:String){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Session")
        fetchRequest.predicate = NSPredicate(format: "sessionID = %@", sessionID)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            //            dataToUpdate.setValue(firstName, forKey: "first_name")
            //            dataToUpdate.setValue(lastName, forKey: "last_name")
            //            dataToUpdate.setValue(email, forKey: "email")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    static func deleteSession(_ sessionID:Int){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Session")
        fetchRequest.predicate = NSPredicate(format: "sessionID = %d", sessionID)
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
            
            print("\n\nsession is deleted\n\n")
        }catch let err{
            print(err)
        }
    }
    
    static func setSessionDuration(_ sessionID:Int,_ duration:Int){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Session")
        fetchRequest.predicate = NSPredicate(format: "sessionID = %d", sessionID)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(duration, forKey: "currentDuration")
            //            dataToUpdate.setValue(lastName, forKey: "last_name")
            //            dataToUpdate.setValue(email, forKey: "email")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    static func deleteAll(context : NSManagedObjectContext){
           //karna dia minta bentuknya umum
           let request : NSFetchRequest<NSFetchRequestResult> = Session.fetchRequest()
           let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
           
           //try? itu sama kyk do catch, kalo dia error return nil
           try? context.execute(deleteRequest)
       }
    
    //MARK: - CloudKit Functions
    static func createNewSession(sessionID:Int, sessionName:String, sessionDate:String){
        let memberRecord = CKRecord(recordType: "Sessions")
        memberRecord["sessionID"] = sessionID as CKRecordValue
        memberRecord["sessionName"] = sessionName as CKRecordValue
        memberRecord["duration"] = 0 as CKRecordValue
        memberRecord["question"] = "" as CKRecordValue
        memberRecord["answerA"] = "" as CKRecordValue
        memberRecord["answerB"] = "" as CKRecordValue
        memberRecord["answerC"] = "" as CKRecordValue
        memberRecord["answerD"] = "" as CKRecordValue
        memberRecord["challengeDuration"] = 0 as CKRecordValue
        memberRecord["isChallengeAvailable"] = false as CKRecordValue
        memberRecord["sessionDate"] = sessionDate as CKRecordValue
        memberRecord["challengeCounter"] = 0 as CKRecordValue
        
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
    
    static func endCurrentSession(sessionID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)

        // Fetch the record to delete from the public database
        privateContainer.perform(query, inZoneWith: nil) {results, error in
            if (error != nil) {
                print(error?.localizedDescription ?? "")
            } else {
                if results?.count == 0 {
                    // On the main thread, update the textView
                    OperationQueue.main.addOperation {
                        print("Sorry, that item doesn't exists in the database.")
                    }
                } else {
                    // Put the first record in the recordToDelete variable
                    let recordToDelete: CKRecord! = results?.first!

                    if let record = recordToDelete {
                        privateContainer.delete(withRecordID: record.recordID) {result, error in
                            if error != nil {
                                OperationQueue.main.addOperation {
                                    print("Delete error: \(String(describing: error?.localizedDescription))")
                                }
                            } else {
                                OperationQueue.main.addOperation {
                                    print("The record was deleted from the database.")
//                                    self.itemNameList.removeAll(keepCapacity: false)
//                                    self.itemPhotoList.removeAll(keepCapacity: false)
//                                    self.fetchAllRecords()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func getSessionByID(sessionID:Int){
        // use default container, we can set custom container by setting
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                isSessionExist = false
                return
            }
            
            if let records = result {
                print("\n\n")
                isSessionExist = false
                sessionData.removeAll()
                records.forEach{
                    print($0)
                    isSessionExist = true
                    sessionData.append(CurrentSessionData(name: $0["sessionName"] as! String, id: $0["sessionID"] as! Int, duration: $0["duration"] as! Int, date: $0["sessionDate"] as! String))
                    print("\n\nis session exist true\n\n")
                }
                print("\n\n")
            }
            
        }
    }
    
    static func setCurrentDuration(sessionID:Int, duration:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["duration"] = duration as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset duration is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset duration is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
            
        }
    }
    
    static func setChallenge(sessionID:Int, question:String, answerA:String, answerB:String, answerC:String, answerD:String, duration:Int, challengeCounter:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        print("\n\nsession yang akan di assign question nya \(question)\n\n")
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["question"] = question as CKRecordValue
                    $0["answerA"] = answerA as CKRecordValue
                    $0["answerB"] = answerB as CKRecordValue
                    $0["answerC"] = answerC as CKRecordValue
                    $0["answerD"] = answerD as CKRecordValue
                    $0["challengeDuration"] = duration as CKRecordValue
                    $0["isChallengeAvailable"] = true as CKRecordValue
                    $0["challengeCounter"] = challengeCounter as CKRecordValue
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset challenge is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset challenge is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
    }
    
    static func getChallengeFromSession(sessionID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        // fecth with array
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                challengeExist = false
                records.forEach{
                    print($0)
                    challengeQuestion = $0["question"] as! String
                    challengeAnswerA = $0["answerA"] as! String
                    challengeAnswerB = $0["answerB"] as! String
                    challengeAnswerC = $0["answerC"] as! String
                    challengeAnswerD = $0["answerD"] as! String
                    challengeDuration = $0["duration"] as! Int
                    challengeExist = $0["isChallengeAvailable"] as! Bool
                    currentChallengeCounter = $0["challengeCounter"] as! Int
                }
                print("\n\n")
            }
            
        }
    }
    
    static func setChallengeToDone(sessionID:Int){
        let container = CKContainer.default()
        let privateContainer = container.publicCloudDatabase
        
        let predicate = NSPredicate(format: "sessionID = %d", sessionID)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        privateContainer.perform(query, inZoneWith: nil) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let records = result {
                print("\n\n")
                records.forEach{
                    print($0)
                    $0["isChallengeAvailable"] = false as CKRecordValue
                    print("\n\n challenge is \(String(describing: $0["isChallengeAvailable"])) in session \(sessionID)\n\n")
                    
                    CKContainer.default().publicCloudDatabase.save($0) { [self] record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("\n\nset challenge answered is Error: \(error.localizedDescription)\n\n")
                            } else {
                                print("\n\nset challenge answered is Done!\n\n")
                            }
                        }
                    }
                }
                print("\n\n")
            }
        }
    }
}
