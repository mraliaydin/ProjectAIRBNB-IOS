//
//  ViewController.swift
//  ProjectAIRBNB
//
//  Created by Ali Aydin on 22.12.2022.
//

import UIKit
import CLTypingLabel

class InboxVC: UIViewController {

    @IBOutlet weak var welcomeLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "You have no new messages"
        
    }
    



}
