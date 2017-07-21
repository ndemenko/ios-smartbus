//
//  CityEntity+CoreDataProperties.swift
//  SmartBus
//
//  Created by Nick Demenko on 29.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity");
    }

    @NSManaged public var highlight: Int
    @NSManaged public var id: Int
    @NSManaged public var name: String?

}
