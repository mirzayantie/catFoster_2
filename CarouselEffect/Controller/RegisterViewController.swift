//
//  RegisterViewController.swift
//  CarouselEffect
//
//  Created by Mirzayantie on 18/09/2019.
//  Copyright © 2019 Mirzayantie. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print ("Form is not valid")
            return
        }
        //register the user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                
                let ref = Database.database().reference(fromURL: "https://flash-chat-e266a.firebaseio.com/")
                let values = ["email": email]
                ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    print("Saved user successfully into Firebase database")
                })
                print ("Register is successful!")
                self.performSegue(withIdentifier: "regGoToCatProfile", sender: self)
            }
        }

}
}