//
//  LoginViewController.swift
//  firebase
//
//  Created by MacOS on 2018/10/17.
//  Copyright © 2018年 MacOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, err) in
            
            if(err != nil){
                let alret = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alret.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alret, animated: true, completion: nil)
            }else{
                
        let view=self.storyboard?.instantiateViewController(withIdentifier: "ViewController")as!ViewController
             self.present(view, animated: true, completion: nil)
               
        
                
            }
        }
        
        
        
        
    }
    
    
    @IBAction func signup(_ sender: Any) {
        
        
        let view=self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController")as!SignupViewController
        self.navigationController?.pushViewController(view, animated: true)
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    
    
    
    
    
    

}
