//
//  ViewController.swift
//  PictureApp
//
//  Created by Safa on 28.08.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        
        //Tum alanlarin kullanici tarafindan doldurulup doldurulmadigi kontrolu
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            //Auth servisine giris isteginde bulunuyoruz
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                
                if error != nil {
                    
                    self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "Error occured")
                }else {
                    
                    //Islem basarili ise Feed TabBar a gidiyoruz
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            errorMessage(title: "Error", message: "Please Enter Email and Password")
        }
    }
    
    
    
    @IBAction func signupClicked(_ sender: Any) {
        
        //Tum alanlarin kullanici tarafindan doldurulup doldurulmadigi kontrolu
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            //Auth servisine kayit isteginde bulunuyoruz
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(title: "Error", message: error?.localizedDescription ?? "Error occured")
                } else {
                    
                    //Islem basarili ise Feed TabBar a gidiyoruz
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        }else {
            errorMessage(title: "Error!", message: "Please Enter Email and Password")
        }
    }


    func errorMessage(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        present(alert, animated: true)
        
    }
    
    
    
}

