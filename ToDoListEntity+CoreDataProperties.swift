//
//  ToDoListEntity+CoreDataProperties.swift
//  TodoList
//
//  Created by mr.root on 9/29/22.
//
//

import Foundation
import CoreData


extension ToDoListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListEntity> {
        return NSFetchRequest<ToDoListEntity>(entityName: "ToDoListEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var img: String?
    @NSManaged public var date: Date?

}

extension ToDoListEntity : Identifiable {

}
