//
//  DetailViewController.swift
//  SmartBus
//
//  Created by Nick Demenko on 30.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var busId: UILabel!
    @IBOutlet weak var fromCity: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var fromInfo: UILabel!
    @IBOutlet weak var toCity: UILabel!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var toInfo: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var reservationCount: UILabel!
    
    var tripId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        let trip = DataProvider.getTrip(tripId)
        busId.text = trip.bus_id.description
        
        fromCity.text = trip.fromCity?.name
        fromDate.text = getHumanDate(trip.from_date)
        fromInfo.text = trip.from_info
        
        toCity.text = trip.toCity?.name
        toDate.text = getHumanDate(trip.to_date)
        toInfo.text = trip.to_info
        
        info.text = trip.info
        price.text = trip.price.description
        reservationCount.text = trip.reservation_count.description
    }
    
    private func getHumanDate(_ nsDate: NSDate?) -> String {
        if let date = nsDate as? Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyyy HH:mm"
            let dateString = formatter.string(from: date)
            return dateString
        }
        else { return "" }
    }
}
