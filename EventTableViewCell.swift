//
//  EventTableViewCell.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 03/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var Note: UILabel!
    @IBOutlet weak var startdate: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
