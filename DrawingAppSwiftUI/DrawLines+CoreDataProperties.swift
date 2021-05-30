//
//  DrawLines+CoreDataProperties.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//
//

import Foundation
import CoreData


extension DrawLines {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawLines> {
        return NSFetchRequest<DrawLines>(entityName: "DrawLines")
    }

    @NSManaged public var saveDate: Date?
    @NSManaged public var saveDrawing: [DrawingEntity]?

}

extension DrawLines : Identifiable {

}
