//
//  SettingsViewController.swift
//  PictureApp
//
//  Created by Safa on 29.08.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
            
        }catch {
            print("Error")
        }
        

    }
    
}
