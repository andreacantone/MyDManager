//
//  RegisterViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ratioTextField: UITextField!
    @IBOutlet weak var bDayPicker: UIDatePicker!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        userEmailTextField.clearButtonMode = .whileEditing
        userPasswordTextField.clearButtonMode = .whileEditing
        repeatPasswordTextField.clearButtonMode = .whileEditing
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        userPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        let userName = userNameTextField.text
        let userSurnme = surnameTextField.text
        let ratio = ratioTextField.text
        
        let date = bDayPicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        
        // Check for empty fields
        if((userEmail!.isEmpty) || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!)
        {
            
            // Display alert message
            
            displayMyAlertMessage("All fields are required");
            
            return;
        }
        
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match");
            return;
            
        }
        
        // Store data
        
    /*
        UserDefaults.standard.setValue(userEmail,forKey: "userEmail")
        UserDefaults.standard.setValue(userPassword,forKey: "userPassword")
*/
        
        guard let profilidata = UserDefaults.standard.object(forKey: "PROFILI") as? NSData else {
            print("'Not found in UserDefaults")
            return
        }
        
        guard var profilesArray = NSKeyedUnarchiver.unarchiveObject(with: profilidata as Data) as? [ProfiloUtente] else {
            print("Could not unarchive from profili")
            return
        }
        let newProfilo = ProfiloUtente(email: userEmail!, password: userPassword!, name: userName!, surname: userSurnme!, ratio: ratio!, bday: dateString)
        profilesArray.append(newProfilo)
        let average: String = ""
            let profiliData = NSKeyedArchiver.archivedData(withRootObject: profilesArray)
            UserDefaults.standard.set(profiliData, forKey: "PROFILI")
            UserDefaults.standard.set(newProfilo.name, forKey: "name")
            UserDefaults.standard.set(newProfilo.surname, forKey: "surname")
            UserDefaults.standard.set(newProfilo.ratio, forKey: "ratio")
            UserDefaults.standard.set(newProfilo.bday, forKey: "birthday")
            UserDefaults.standard.set(newProfilo.email, forKey: "email")
            UserDefaults.standard.set(newProfilo.password, forKey: "password")
            UserDefaults.standard.set(average, forKey: "average")
            UserDefaults.standard.synchronize()

        
        let myAlert = UIAlertController(title:"ALERT", message: "Registration complete!", preferredStyle:UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "CHIUDI", style: UIAlertActionStyle.default, handler:
            {
                (paramAction:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }
        )
        myAlert.addAction(action)
        self.present(myAlert, animated:true, completion:nil)
        
    }
    
    
    func displayMyAlertMessage(_ userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    @IBAction func iHaveAnAccountButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
