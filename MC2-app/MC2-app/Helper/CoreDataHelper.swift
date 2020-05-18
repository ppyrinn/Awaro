//
//  CoreDataHelper.swift
//  Awaro
//
//  Created by Poppy on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import CoreData

//template biar bisa dipake berkali2
struct CoreDataHelper {
    var context : NSManagedObjectContext
    
    func fetchAll<T : NSManagedObject>() -> [T] {
        let request = T.fetchRequest()
        do {
            return try context.fetch(request) as? [T] ?? []
        } catch {
            return []
        }
    }
}

