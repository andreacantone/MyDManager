//
//  modifyProfile.swift
//  My Diabetic Manager
//
//  Created by Anna Belardo on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class modifyProfile: UIViewController {
    @IBOutlet var newN : UITextField!
    @IBOutlet var newS: UITextField!
    @IBOutlet var newI : UITextField!
    @IBOutlet var newE : UITextField!
    @IBOutlet var newB : UITextField!
    @IBOutlet var newP: UITextField!
    @IBOutlet var newIm : UIImageView!
    @IBOutlet var save :  UIButton!
    
    var newName : String = ""
    var newSurname : String = ""
    var newICHO : String = ""
    var newEmail : String = ""
    var newBirthdate : String = ""
    var newPassword : String = ""
    var newImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newN.text = newName
        newS.text = newSurname
        newI.text = newICHO
        newE.text = newEmail
        newB.text = newBirthdate
        newP.text = newPassword
        newIm.image = UIImage (named: newImage)
        save.layer.cornerRadius = 7
        save.layer.borderColor = hexStringToUIColor(hex: "034f84").cgColor
        save.layer.borderWidth = 1.0
        
        
        // Do any additional setup after loading the view.
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Salvo i nuovi dati del profilo modificati
    @IBAction func save(_ sender: UIButton){
        
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}

