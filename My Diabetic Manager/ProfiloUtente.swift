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
    var name: String
    var surname: String
    var ratio: String
    var bday: String
    
    init(email: String, password: String, name:String, surname:String, ratio:String, bday:String) {
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
        self.ratio = ratio
        self.bday = bday
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        self.password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.surname = aDecoder.decodeObject(forKey: "surname") as? String ?? ""
        self.ratio = aDecoder.decodeObject(forKey: "ratio") as? String ?? ""
        self.bday = aDecoder.decodeObject(forKey: "bday") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(surname, forKey: "surname")
        aCoder.encode(ratio, forKey: "ratio")
        aCoder.encode(bday, forKey: "bday")
    }
}
