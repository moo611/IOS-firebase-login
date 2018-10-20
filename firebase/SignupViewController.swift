//
//  SignupViewController.swift
//  firebase
//
//  Created by MacOS on 2018/10/17.
//  Copyright © 2018年 MacOS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage



class SignupViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    
    @IBAction func save(_ sender: Any) {
        
      
        savedata()
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.isUserInteractionEnabled=true
        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @objc func imagePicker(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        imageview.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func savedata(){
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, err) in
            
            let uid = Auth.auth().currentUser?.uid
            let uri = UIImageJPEGRepresentation(self.imageview.image!, 0.1)
            let storageRef = Storage.storage().reference().child("users").child(uid!)
            
            
            storageRef.putData(uri!, metadata: nil, completion: { (data, error) in
                storageRef.downloadURL(completion: { (url, err) in
                    
                    
                    let value:Dictionary=[
                        "uid":uid,
                        "imageurl":url?.absoluteString,
                        "name":self.name.text
                        

                        ] as [String : Any]
                    
                    Database.database().reference().child("users").child(uid!).setValue(value)
                    
                })
                
            })
            
        }
        
        
        

    
}

}
