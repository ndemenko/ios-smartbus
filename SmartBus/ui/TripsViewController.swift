//
//  ViewController.swift
//  SmartBus
//
//  Created by Nick Demenko on 27.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import UIKit
import CoreData

class TripsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var busTimeTableView: UITableView!
    var dataSource:TripsDataSource!
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refresh trips")
        refresher.addTarget(self, action: #selector(TripsViewController.refreshData), for: UIControlEvents.valueChanged)
        busTimeTableView.addSubview(refresher)
        refresher.beginRefreshing()
        
        self.dataSource = TripsDataSource(busTimeTableView)
        busTimeTableView.dataSource = dataSource
        DataProvider.getTrips(onDataLoaded, self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "show_trip_details",
            let destination = segue.destination as? DetailViewController
        {
            if let trip = busTimeTableView.cellForRow(at: busTimeTableView.indexPathForSelectedRow! as IndexPath) as? TripCell {
                destination.tripId = (trip.tripId)!
            }
        }
    }
    
    func refreshData() {
        busTimeTableView.allowsSelection = false
        DataProvider.refreshData(onDataLoaded, self)
    }
    
    func onDataLoaded(_ trips: [TripEntity]){
        refresher.endRefreshing()
        self.dataSource.reloadDataFromDB(trips)
        busTimeTableView.allowsSelection = true
        
        if trips.count == 0 && self.presentedViewController == nil{
            busTimeTableView.isHidden = true
            createSubviews()
        }
    }
    
    func reloadButtonAction(sender: UIButton!) {
        deleteSubviews()
        busTimeTableView.isHidden = false
        refreshData()
        refresher.beginRefreshing()
    }
    
    func deleteSubviews() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    func createSubviews() {
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: 230, height: 21))
        label.center.x = self.view.center.x
        label.textAlignment = .center
        label.text = "Nothing found for this request"
        label.tag = 101
        self.view.addSubview(label)
        
        let reloadButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        reloadButton.center = self.view.center
        reloadButton.backgroundColor = .green
        reloadButton.setTitle("Try again", for: .normal)
        reloadButton.addTarget(self, action: #selector(reloadButtonAction), for: .touchUpInside)
        reloadButton.tag = 100
        self.view.addSubview(reloadButton)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        deleteSubviews()
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        deleteSubviews()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if busTimeTableView.isHidden {
            createSubviews()
        }
    }
}
