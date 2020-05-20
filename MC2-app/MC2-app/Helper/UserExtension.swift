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
        let memberRecord = CKRecord(recordType: "Members")
        memberRecord["userID"] = id as CKRecordValue
        memberRecord["fullName"] = fullName as CKRecordValue
        memberRecord["email"] = email as CKRecordValue

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
    
//    static func getMemberBySpecificEmail(email:String){
//            // use default container, we can set custom container by setting
//            let container = CKContainer.default()
//            let privateContainer = container.publicCloudDatabase
//            
//            // fetch with query string
//    //        let predicate = NSPredicate(format: "name BEGINSWITH %@", "Cafee")
//    //        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
//            
//            // fecth with array
//            let predicate = NSPredicate(format: "email = %@", email)
//            let query = CKQuery(recordType: "Members", predicate: predicate)
//            
//            privateContainer.perform(query, inZoneWith: nil) { (result, error) in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//                
//                if let records = result {
//                    records.forEach{print($0)}
//                }
//                
//            }
//        }
    
}
