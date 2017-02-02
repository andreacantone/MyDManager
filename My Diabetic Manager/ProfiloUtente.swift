//
//  ProfiloUtente.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit
import Foundation

class ProfiloUtente: NSObject, NSCoding {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        self.password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
    }
}
