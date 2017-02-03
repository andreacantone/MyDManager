//
//  ProfileSummary.swift
//  My Diabetic Manager
//
//  Created by Anna Belardo on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class ProfileSummary: UIViewController {
    
    @IBOutlet var LoggedName: UILabel!
    @IBOutlet var LoggedSurname: UILabel!
    @IBOutlet var LoggedICHO: UILabel!
    @IBOutlet var OminoImage: UIImageView!
    @IBOutlet var LoggedAverage: UILabel!
    
    //DA VEDERE se fisso o se deve funzionare il log in
    var Name:String = "Anna"
    var Surname = "Belardo"
    var ICHO = "12"
    var Email = "anna@belardo.it"
    var Birthdate = "02/09/1994"
    var Password = "password"
    //ENZO FAI COSE A QUESTA VARIABILE
    var Average = "8"
    
    
    
    override func viewDidLoad() {
        //Label per Nome Profilo
        LoggedName.layer.borderWidth = 0.5
        LoggedName.layer.cornerRadius = 7
        LoggedName.layer.borderColor = UIColor.lightGray.cgColor
        LoggedName.layer.backgroundColor = hexStringToUIColor(hex: "EBEBF1").cgColor
        LoggedName.text = Name
        //Label per Cognome Profilo
        LoggedSurname.layer.borderWidth = 0.5
        LoggedSurname.layer.cornerRadius = 7
        LoggedSurname.layer.borderColor = UIColor.lightGray.cgColor
        LoggedSurname.layer.backgroundColor = hexStringToUIColor(hex: "EBEBF1").cgColor
        LoggedSurname.text = Surname
        //Label per ICHO Profilo
        LoggedICHO.layer.borderWidth = 0.5
        LoggedICHO.layer.cornerRadius = 7
        LoggedICHO.layer.borderColor = UIColor.lightGray.cgColor
        LoggedICHO.layer.backgroundColor = hexStringToUIColor(hex: "EBEBF1").cgColor
        LoggedICHO.text = ICHO
        //immagine rotonda
        OminoImage.layer.borderWidth = 1
        OminoImage.layer.masksToBounds = false
        OminoImage.layer.cornerRadius = OminoImage.frame.size.height/2
        OminoImage.layer.cornerRadius = OminoImage.frame.size.width/2
        OminoImage.clipsToBounds = true
        OminoImage.image = UIImage(named: "ominopc")
        OminoImage.layer.borderColor = hexStringToUIColor(hex: "034f84").cgColor

        //Label per valori glicemici
        LoggedAverage.layer.borderWidth = 0.5
        LoggedAverage.layer.cornerRadius = 7
        LoggedAverage.layer.borderColor = UIColor.lightGray.cgColor
        LoggedAverage.layer.backgroundColor = hexStringToUIColor(hex: "EBEBF1").cgColor
        LoggedAverage.text = Average
        
        //gesture per swap DAAGGIUNGERE
        super.viewDidLoad()
      
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifyProfile"{
            let destinationController = segue.destination as! modifyProfile
            destinationController.newName = Name
            destinationController.newSurname = Surname
            destinationController.newICHO = ICHO
            destinationController.newEmail = Email
            destinationController.newPassword = Password
            destinationController.newImage = "ominopc"
            destinationController.newBirthdate = Birthdate
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }

    }
    
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        
        UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    
}
