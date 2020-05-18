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
            print("\n\nsave data ke entity user core data berhasil\n\n")
            //                id += 1
        }catch let err{
            print(err)
        }
    }
}
