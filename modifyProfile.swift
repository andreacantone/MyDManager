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
    
    /*
    
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
   /* @IBAction func photoFromLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender
    }*/
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
    */
    
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
    @IBAction func save(_ sender: UIBarButtonItem){
        //roba per foto
        let imageData = UIImageJPEGRepresentation(pickedImaged.image!, 0.6)
        let compressJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressJPEGImage!, nil, nil, nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo :[NSObject: AnyObject]!) {
        pickedImaged.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
}

