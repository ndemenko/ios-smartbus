//
//  TripCell.swift
//  SmartBus
//
//  Created by Nick Demenko on 27.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var tripDateFrom: UILabel!
    @IBOutlet weak var tripPrice: UILabel!
    var tripId: Int!
    
}
