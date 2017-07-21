//
//  CoreDataManager.swift
//  SmartBus
//
//  Created by Nick Demenko on 29.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import CoreData

final class CoreDataManager {
    
    static var managedObjextContext:NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Properties
    private let modelName: String
    
    // MARK: - Initialization
    init(modelName: String) {
        self.modelName = modelName
    }
    
    static func saveToDB(_ data: [NSDictionary]) -> [TripEntity]{
        clearDB()
        var cityEntities = [CityEntity]()
        var trips = [TripEntity]()
        for tripItem in data {
            let trip = NSEntityDescription.insertNewObject(forEntityName: "TripEntity", into: self.managedObjextContext) as! TripEntity
            trip.bus_id = tripItem["bus_id"] as! Int
            
            trip.fromCity = createCity(tripItem["from_city"] as! NSDictionary, &cityEntities)
            trip.from_date = self.parseDateAndTime((tripItem["from_date"] as! String) + (tripItem["from_time"] as! String))
            trip.from_info = tripItem["from_info"] as? String
            
            trip.toCity = createCity(tripItem["to_city"] as! NSDictionary, &cityEntities)
            trip.to_date = self.parseDateAndTime((tripItem["to_date"] as! String) + (tripItem["to_time"] as! String))
            trip.to_info = tripItem["to_info"] as? String
            
            trip.id = tripItem["id"] as! Int
            trip.info = tripItem["info"] as? String
            trip.price = tripItem["price"] as! Int
            trip.reservation_count = tripItem["reservation_count"] as! Int
            
            trips.append(trip)
        }
        do {
            try self.managedObjextContext.save()
        }catch {
            print("Could not save data \(error.localizedDescription)")
        }
        return trips
    }
    
    private static func createCity(_ items: NSDictionary, _ cityEntities: inout [CityEntity]) -> CityEntity {
        var city = cityEntities.first(where: { (entity: CityEntity) -> Bool in
            return entity.id == items["id"] as! Int
        });
        
        if city==nil{
            city = NSEntityDescription.insertNewObject(forEntityName: "CityEntity", into: self.managedObjextContext) as? CityEntity
            city?.id = items["id"] as! Int
            city?.name = items["name"] as? String
            city?.highlight = items["highlight"] as! Int
            cityEntities.append(city!)
        }
        return city!
    }
    
    private static func parseDateAndTime(_ string: String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        
        let date = dateFormatter.date(from: string)!
        return date as NSDate
    }
    
    static func fetchTrips() -> [TripEntity]{
        //let tripClassName:String = String(describing: TripEntity.self)
        //let cityClassName:String  = String(describing: CityEntity.self)
        let fetchRequest:NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        var searchResults = [TripEntity]()
        do{
            searchResults = try managedObjextContext.fetch(fetchRequest)
            
            
            
            //print("\n \n number of trips: \(searchResults.count) \n \n ")
            
//            for result in searchResults as [TripEntity]{
//                print("\(result.id) \(result.bus_id) city name: \(result.fromCity?.name)")
//            }
            
            //let cityFetchRequest:NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
            //let cityResults = try managedObjextContext.fetch(cityFetchRequest)
            //print("\n \n number of cities: \(cityResults.count) \n \n ")
            
//            for result in cityResults as [CityEntity]{
//                print("\(result.id) \(result.name) \(result.highlight)")
//            }
        }
        catch{
            print("Fetch error: \(error)")
        }
        return searchResults
    }
    
    private static func clearDB() {
        let fetchRequest:NSFetchRequest<TripEntity> = TripEntity.fetchRequest()
        do{
            let searchResults = try managedObjextContext.fetch(fetchRequest)
            for result in searchResults as [TripEntity]{
                managedObjextContext.delete(result)
            }
        }
        catch{
            print("Clear db error: \(error)")
        }
    }
    
    
}
