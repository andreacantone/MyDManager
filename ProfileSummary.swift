//
//  ProfileSummary.swift
//  My Diabetic Manager
//
//  Created by Anna Belardo on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class ProfileSummary: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var LoggedName: UILabel!
    @IBOutlet var LoggedSurname: UILabel!
    @IBOutlet var LoggedICHO: UILabel!
    @IBOutlet var OminoImage: UIImageView!
    
    //DA VEDERE se fisso o se deve funzionare il log in
    var Name = "Anna"
    var Surname = "Belardo"
    var ICHO = "12"
    var Email = "anna.belardo94@gmail.com"
    var Birthdate = "02/09/1994"
    var Password = "raffaelegay"
    
    
    
    override func viewDidLoad() {
        //Label per Nome Profilo
        LoggedName.layer.borderWidth = 1.0
        LoggedName.layer.cornerRadius = 7
        LoggedName.layer.borderColor = UIColor.gray.cgColor
        LoggedName.text = Name
        //Label per Cognome Profilo
        LoggedSurname.layer.borderWidth = 1.0
        LoggedSurname.layer.cornerRadius = 7
        LoggedSurname.layer.borderColor = UIColor.gray.cgColor
        LoggedSurname.text = Surname
        //Label per ICHO Profilo
        LoggedICHO.layer.borderWidth = 1.0
        LoggedICHO.layer.cornerRadius = 7
        LoggedICHO.layer.borderColor = UIColor.gray.cgColor
        LoggedICHO.text = ICHO
        //immagine rotonda
        OminoImage.layer.borderWidth = 1
        OminoImage.layer.masksToBounds = false
        OminoImage.layer.cornerRadius = OminoImage.frame.size.height/2
        OminoImage.layer.cornerRadius = OminoImage.frame.size.width/2
        OminoImage.clipsToBounds = true
        OminoImage.image = UIImage(named: "ominopc")
        
        //gesture per swap
        super.viewDidLoad()
        if revealViewController() != nil {
            menuButton.target=revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModifyProfile"{
            let destinationController = segue.destination as! ModifyProfile
            destinationController.newName = Name
            destinationController.newSurname = Surname
            destinationController.newICHO = ICHO
            destinationController.newEmail = Email
            destinationController.newPassword = Password
            destinationController.newImage = "ominopc"
            destinationController.newBirthdate = Birthdate
            
        }
    }
    
}
