//
//  DrawSaveDataManage.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/29.
//

import Foundation
import CoreData


final class DrawSaveDataManager {
    static let shared = DrawSaveDataManager()
    
    private init() {}
    private var container: NSPersistentContainer?
    private let entityName = "DrawLines"

    private var mainContext: NSManagedObjectContext {
        guard let context = container?.viewContext else {
            fatalError()
        }
        return context
    }
    var histories:[DrawLines] = []

    func setup(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container?.loadPersistentStores(completionHandler: { (desc, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        })
    }
    func save(lines:[DrawingEntity],saveDate:Date = Date()) {
        if let historyEntity = NSEntityDescription.entity(forEntityName: entityName, in: mainContext), let saveData = NSManagedObject(entity: historyEntity, insertInto: mainContext) as? DrawLines {
            saveData.saveDate = saveDate
            saveData.saveDrawing = lines
        }
        saveMainContext()
        getData ()
    }
    func getData() {
        let dateSort = NSSortDescriptor(key: "saveDate", ascending: false)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.sortDescriptors = [dateSort]
        do {
            if let fetchResult = try mainContext.fetch(fetchRequest) as? [DrawLines] {
                histories = fetchResult
            }
        } catch {
            print(error.localizedDescription)
        }


    }

    func saveMainContext() {
        mainContext.performAndWait {
            if self.mainContext.hasChanges {
                do {
                    try self.mainContext.save()
                    print("save success")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

}
