//
//  DataManger.swift
//  TodoList
//
//  Created by mr.root on 9/29/22.
//

import Foundation
import CoreData
import UIKit
open class DataManger: NSObject {
    public static let shareInstance = DataManger()
    private override init() {}
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func saveData(_ data: [Note]) {
        let list = ToDoListEntity(context: context)
        for item in data {
            list.name = item.name
            list.img = convertImgaeToBase64(image: item.img!)
            list.date = item.date
        }
        saveContext()
    }
    func fetchData() -> [Note] {
        var lists: [Note] = []
        let fetchList: NSFetchRequest<ToDoListEntity> = ToDoListEntity.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(ToDoListEntity.date), ascending: false)
        fetchList.sortDescriptors = [sort]
        do {
            let result = try context.fetch(fetchList)
            for i in result {
                let newData = Note(name: i.name!, id: i.objectID, img: convertBase64ToImage(imageString: i.img!), date: i.date!)
                lists.append(newData)
            }
        }
        catch {
            print("Error")
        }
        return lists
    }
    func updateData(with id: NSManagedObjectID, _ data : Note) {
        if let object = try? (context.existingObject(with: id)) as? ToDoListEntity {
            object.name = data.name
            object.img = convertImgaeToBase64(image: data.img!)
        }
        saveContext()
      
    }
    func deleteObject(at id: NSManagedObjectID){
        if let object = try? context.existingObject(with: id){
            context.delete(object)
        }
        saveContext()
    }
    func convertImgaeToBase64(image: UIImage) -> String {
           let imageData: Data? = image.jpegData(compressionQuality: 0.4)
           let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
           return imageStr
       }
    func convertBase64ToImage(imageString: String ) -> UIImage {
           let imageData = Data(base64Encoded: imageString , options: .ignoreUnknownCharacters)!
           return UIImage(data: imageData)!
       }
        

    // MARK: - Core Data Saving support
      func saveContext () {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  // Replace this implementation with code to handle the error appropriately.
                  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    

    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TodoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
       
}
