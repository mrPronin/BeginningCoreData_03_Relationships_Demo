//
//  Person+CoreDataProperties.swift
//  myDevices
//
//  Created by Aleksandr Pronin on 4/30/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String
    @NSManaged var devices: NSSet

}
