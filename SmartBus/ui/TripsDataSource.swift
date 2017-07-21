//
//  TripsController.swift
//  SmartBus
//
//  Created by Nick Demenko on 28.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import UIKit

class TripsDataSource: NSObject, UITableViewDataSource  {
    
    var trips: [TripEntity] = []
    var tableView: UITableView
    //let alert: UIAlertController!

    // MARK: - Table view data source
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
 
//
//        alerts disabled for testing
//
//        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//        
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//        
//        alert.view.addSubview(loadingIndicator)
//        viewController.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tripCell = tableView.dequeueReusableCell(withIdentifier: "tripItem", for: indexPath) as! TripCell
        
        let trip = self.trips[indexPath.row]
        if (trip.fromCity?.name) != nil {
            tripCell.tripName.text = (trip.fromCity?.name)! + " - " + (trip.toCity?.name)!
        }
        else {
            self.tableView.isScrollEnabled = false
            return tripCell
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        let dateString = formatter.string(from: trip.from_date as! Date)
        tripCell.tripDateFrom.text = dateString
        
        tripCell.tripId = trip.id
        tripCell.tripPrice.text = trip.price.description
        return tripCell
    }
    
    // MARK: - Table view db logic
    
    func reloadDataFromDB(_ trips: [TripEntity]){
        self.trips = trips
        self.tableView.reloadData()
        if !self.tableView.isScrollEnabled {
            self.tableView.isScrollEnabled = true
        }
        //self.alert.dismiss(animated: false, completion: nil)
    }
}
