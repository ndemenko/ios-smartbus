//
//  TripEntity+CoreDataProperties.swift
//  SmartBus
//
//  Created by Nick Demenko on 29.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import Foundation
import CoreData


extension TripEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripEntity> {
        return NSFetchRequest<TripEntity>(entityName: "TripEntity");
    }

    @NSManaged public var bus_id: Int
    @NSManaged public var id: Int
    @NSManaged public var info: String?
    @NSManaged public var price: Int
    @NSManaged public var reservation_count: Int
    @NSManaged public var from_info: String?
    @NSManaged public var from_date: NSDate?
    @NSManaged public var to_date: NSDate?
    @NSManaged public var to_info: String?
    @NSManaged public var fromCity: CityEntity?
    @NSManaged public var toCity: CityEntity?

}
