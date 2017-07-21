//
//  DataProvider.swift
//  SmartBus
//
//  Created by Nick Demenko on 31.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import Foundation

class DataProvider {
    
    private static var trips = [TripEntity]()
    //static var callbackFunc: (([TripEntity]) -> Void)? = nil
    
    static func getTrips(_ callback: @escaping ([TripEntity]) -> Void, _ viewController:UIViewController ) {
        //callbackFunc = callback
        if(trips.count>0){
            callback(trips)
        }
        else {
            DispatchQueue.global(qos: .userInitiated).async {
            trips = CoreDataManager.fetchTrips()
                DispatchQueue.main.async {
                    if(trips.count>0){
                        callback(trips)
                    }
                    else{
                        refreshData(callback, viewController)
                    }
                }
            }
        }
    }
    
    static func getTrip(_ id: Int) -> TripEntity{
        return trips.first(where: { (entity: TripEntity) -> Bool in
            return entity.id == id
        })!
    }
    
    static func refreshData(_ callback: @escaping ([TripEntity]) -> Void, _ viewController:UIViewController ){
        trips.removeAll()
        NetworkUtils.getJSON({ (_ success: Bool, _ error_message: String, _ data: [NSDictionary]?) in
            if success {
                DispatchQueue.global(qos: .userInitiated).async {
                    trips = CoreDataManager.saveToDB(data!)
                    DispatchQueue.main.async {
                        callback(trips)
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Warning", message: error_message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                viewController.present(alert, animated: true, completion: { () in callback(trips) })
            }
        })
    }
    
}
