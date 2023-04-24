//
//  SignInVC.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 26.12.2022.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInButtonPressed(_ sender: UIButton) {
            
        if(emailText.text==""||passText.text==""){
            displayAlert(header: "Input Error", msg: "Email or Pass cannot be empty")
        }else if (passText.text!.count < 6){
            displayAlert(header: "Input Error", msg: "Pass cannot be less than 6 char")
        }else{
            if let email = emailText.text, let password = passText.text{
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    
                    if let e = error {
                        if(e.localizedDescription.description=="The password is invalid or the user does not have a password."){
                            self.displayAlert(header: "Error", msg: "Wrong pass")
                        }
                        print(e)
                    }else{
                        //Navigate to the Homepage
                        self.performSegue(withIdentifier: "loginToHome", sender: self)
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
