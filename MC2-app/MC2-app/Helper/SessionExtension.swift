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
}
