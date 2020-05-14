//
//  CreateAccountViewController.swift
//  Homework21
//
//  Created by Kato on 5/14/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var newUsernameTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCreateAccountTapped(_ sender: UIButton) {
        save()
        print("account created")
        //dismiss(animated: true)
    }
    
    
}

extension CreateAccountViewController {
    
    func save() {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserAccount", in: context)
        
        let userObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        userObject.setValue(newUsernameTextField.text!, forKey: "username")
        userObject.setValue(newPasswordTextField.text!, forKey: "password")
        
        do {
            try context.save()
            print("saved successfully")
        }
        catch {
            print("failed")
        }
    }
}
