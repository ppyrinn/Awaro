//
//  UIViewController+Extension.swift
//  Awaro
//
//  Created by Poppy on 18/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension UIViewController{
    //fungsi buat ambil context dari persistent container, utk save/fetch/eksekusinya dsb
    func getViewContext() -> NSManagedObjectContext {
        //cari tau appdelegate itu yg mana, casting biar bisa diakses container nya
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
}
