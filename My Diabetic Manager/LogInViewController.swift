//
//  LogInViewController.swift
//  My Diabetic Manager
//
//  Created by Vincenzo De Rosa on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

struct MyVariable {
    static var usr_logged = ProfiloUtente(email: "", password: "")
}


class LogInViewController: UIViewController, UITextFieldDelegate{
        
        @IBOutlet weak var userEmailTextField: UITextField!
        @IBOutlet weak var userPasswordTextField: UITextField!
        
        override func viewDidLoad() {
            userEmailTextField.clearButtonMode = .whileEditing
            userPasswordTextField.clearButtonMode = .whileEditing
            super.viewDidLoad()
            userEmailTextField.delegate = self
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
        
    
        @IBAction func loginButtonTapped(_ sender: AnyObject) {

            let userEmail = userEmailTextField.text;
            let userPassword = userPasswordTextField.text;
            
            /*
            let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
            let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");

            
            if(userEmailStored == userEmail)
            {
                if(userPasswordStored == userPassword)
                {
                    // Login is successfull
                    UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                    UserDefaults.standard.synchronize();
                    
                    self.dismiss(animated: true, completion:nil);

                }
            }
*/
            

                guard let profiliData = UserDefaults.standard.object(forKey: "PROFILI") as? NSData else {
                    print("'Not found in UserDefaults")
                    return
                }
                
                guard let profilesArray = NSKeyedUnarchiver.unarchiveObject(with: profiliData as Data) as? [ProfiloUtente] else {
                    print("Could not unarchive from profili")
                    return
                }
            
            for user in profilesArray{
                if user.email == userEmail && user.password == userPassword{
                    UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                    UserDefaults.standard.synchronize();
                    self.dismiss(animated: true, completion:nil);
                    MyVariable.usr_logged = user
                    return
                }
            }
            
        }
     
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
    
        
        
    }
