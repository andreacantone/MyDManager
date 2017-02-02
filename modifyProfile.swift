//
//  modifyProfile.swift
//  My Diabetic Manager
//
//  Created by Anna Belardo on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit


class modifyProfile: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet var newN : UITextField!
    @IBOutlet var newS: UITextField!
    @IBOutlet var newI : UITextField!
    @IBOutlet var newE : UITextField!
    @IBOutlet var newB : UITextField!
    @IBOutlet var newP: UITextField!
    @IBOutlet var newIm : UIImageView!
    @IBOutlet var save :  UIBarButtonItem!
    @IBOutlet weak var pickedImaged: UIImageView!

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
        //immagine rotonda
        newIm.layer.borderWidth = 1
        newIm.layer.masksToBounds = false
        newIm.layer.cornerRadius = newIm.frame.size.height/2
        newIm.layer.cornerRadius = newIm.frame.size.width/2
        newIm.clipsToBounds = true
        newIm.layer.borderColor = hexStringToUIColor(hex: "034f84").cgColor
        newIm.image = UIImage(named: "ominopc")
        newIm.image = UIImage (named: newImage)
        /*
        super.viewDidLoad()
        picker.delegate = self
        */
        
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
  //scattare uan foto
    @IBAction func camerabuttonaction (_ sender: UIButton){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                ;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated:  true,
                         completion: nil)
        }

    }
    // scegliere foto da libreria
    @IBAction func photolibraryaction (_ sender: UIButton){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated:  true, completion: nil)
        }
    }
    
    
    
    
    
    //Salvo i nuovi dati del profilo modificati
    @IBAction func save(_ sender: UIButton){
        let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6)
        let compressJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressJPEGImage!, nil, nil, nil)
        saveNotice()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo :[NSObject: AnyObject]!) {
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    func saveNotice () {
        let alertController = UIAlertController(title: "Successfully Update!", message: "Your data was successfully update.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present (alertController, animated: true, completion: nil)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}

