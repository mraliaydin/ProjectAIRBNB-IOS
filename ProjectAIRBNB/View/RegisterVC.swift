//
//  RegisterVC.swift
//  ProjectAIRBNB
//
//  Created by Ali Aydin on 23.12.2022.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if(emailText.text==""||passText.text==""){
            displayAlert(header: "Input Error", msg: "Email or Pass cannot be empty")
        }else if (passText.text!.count < 6){
            displayAlert(header: "Input Error", msg: "Pass cannot be less than 6 char")
        }else{
            if let email = emailText.text, let password = passText.text{
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e)
                    }else{
                        //Navigate to the Homepage
                        self.performSegue(withIdentifier: "home", sender: self)
                    }
                }
            }
        }
    }
    
    func displayAlert(header: String, msg: String) {
        // Creating an Alert and display the result
        let mAlert = UIAlertController(title: header, message: msg, preferredStyle: UIAlertController.Style.alert)
        // Event Handler for the button
        mAlert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        // Displaying the Alert
        self.present(mAlert, animated: true, completion: nil)
    }
    

}
