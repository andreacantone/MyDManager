//
//  singleSourceTableViewCell.swift
//  Menu
//
//  Created by De Luca Raffaele on 28/01/17.
//  Copyright © 2017 iOSFoundation. All rights reserved.
//

import UIKit

class singleSourceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SingleCourseName: UILabel!
    @IBOutlet weak var SingleCourseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
