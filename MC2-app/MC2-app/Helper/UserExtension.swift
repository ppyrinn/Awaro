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
    
}
