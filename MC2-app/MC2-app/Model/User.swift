//
//  User.swift
//  MC2-app
//
//  Created by Poppy on 06/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import AuthenticationServices
import CoreData

struct UserModel{
    var id:String
    var firstName:String
    var lastName:String
    var email:String
    
    init(credentials : ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}

var users:UserModel?
var userID:Int?

extension UserModel:CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        ID: \(id)
        First Name : \(firstName)
        Last Name : \(lastName)
        Email : \(email)
        """
    }
}

// CRUD


//// fungsi refrieve semua data
//func retrieve() -> [UserModel]{
//
//    var users = [UserModel]()
//
//    // referensi ke AppDelegate
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    // managed context
//    let managedContext = appDelegate.persistentContainer.viewContext
//
//    // fetch data
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//
//    do{
//        let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
//
//        result.forEach{ user in
//            users.append(
//                UserModel(
//                    id:user.value(forKey: "userID") as! Int,
//                    firstName: user.value(forKey: "firstName") as! String,
//                    lastName: user.value(forKey: "lastName") as! String,
//                    email: user.value(forKey: "email") as! String
//                )
//            )
//        }
//    }catch let err{
//        print(err)
//    }
//
//    return users
//
//}

//func update(_ firstName:String, _ lastName:String, _ email:String){
//
//    // referensi ke AppDelegate
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//    // managed context
//    let managedContext = appDelegate.persistentContainer.viewContext
//
//    // fetch data to delete
//    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
//    fetchRequest.predicate = NSPredicate(format: "email = %@", email)
//
//    do{
//        let fetch = try managedContext.fetch(fetchRequest)
//        let dataToUpdate = fetch[0] as! NSManagedObject
//        dataToUpdate.setValue(firstName, forKey: "first_name")
//        dataToUpdate.setValue(lastName, forKey: "last_name")
//        dataToUpdate.setValue(email, forKey: "email")
//
//        try managedContext.save()
//    }catch let err{
//        print(err)
//    }
//
//}
//
//// fungsi menghapus by email user
//func delete(_ email:String){
//
//    // referensi ke AppDelegate
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//    // managed context
//    let managedContext = appDelegate.persistentContainer.viewContext
//
//    // fetch data to delete
//    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
//    fetchRequest.predicate = NSPredicate(format: "email = %@", email)
//
//    do{
//        let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
//        managedContext.delete(dataToDelete)
//
//        try managedContext.save()
//    }catch let err{
//        print(err)
//    }
//
//}
