//
//  RegisterViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        
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
        UserDefaults.standard.setValue(userEmail,forKey: "userEmail")
        UserDefaults.standard.setValue(userPassword,forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
        let myAlert = UIAlertController(title:"ALERT", message: "Registration complete!", preferredStyle:UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "CHIUDI", style: UIAlertActionStyle.default, handler:
            {(paramAction:UIAlertAction!) in
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
