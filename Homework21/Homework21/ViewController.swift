//
//  ViewController.swift
//  Homework21
//
//  Created by Kato on 5/14/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var users = [UserClass]()
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func onLogInTapped(_ sender: UIButton) {
        if getUser(username: usernameTextField.text!, password: passwordTextField.text!) {
            
            performSegue(withIdentifier: "notes_segue", sender: self)
        }
        else
        {
            let alert1 = UIAlertController(title: "Try Again", message: "Incorrect username or password.", preferredStyle: .alert)
            alert1.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert1, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NotesTableViewController
        vc.loggedUsername = self.usernameTextField.text!
    }
    
    @IBAction func onNewAccountTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let temp = storyboard.instantiateViewController(withIdentifier: "create_account_vc")
        
        self.navigationController?.pushViewController(temp, animated: true)
    }
    
    
    
}

extension ViewController {
    
    func getUser(username: String, password: String)-> Bool {
        
        var returnValue = false
        
        let container = AppDelegate.coreDataContainer
        
        //context
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserAccount")
       
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let data = result as? [NSManagedObject] else {return false}

            for item in data {
                if let p = item as? UserAccount {
                    if username == p.username && password == p.password {
                        returnValue = true
                        break
                    }
                }
            }
            
        }
        catch {}
      
        return returnValue
    }
}

class UserClass {
    var username = ""
    var password = ""
}

