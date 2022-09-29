//
//  Note.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import Foundation
import CoreData
import UIKit
struct Note {
    var name: String
    var id: NSManagedObjectID? = nil
    var img: UIImage?
    var date: Date
    
}
