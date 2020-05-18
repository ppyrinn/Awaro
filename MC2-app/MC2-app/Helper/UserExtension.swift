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
            print("\n\nsave data ke entity user core data berhasil\n\n")
            //                id += 1
        }catch let err{
            print(err)
        }
        
    }
}
