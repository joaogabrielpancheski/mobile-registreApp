//
//  UIViewController+Context.swift
//  Registre
//
//  Created by user210579 on 1/10/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
