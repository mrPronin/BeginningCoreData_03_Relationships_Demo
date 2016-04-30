//
//  Device.swift
//  myDevices
//
//  Created by Greg Heo on 2015-08-14.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import CoreData

class Device: NSManagedObject {

  var deviceDescription: String {
    return "\(name) (\(deviceType))"
  }

}
